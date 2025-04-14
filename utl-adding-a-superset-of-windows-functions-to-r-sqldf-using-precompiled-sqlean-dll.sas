%let pgm=utl-adding-a-superset-of-windows-functions-to-r-sqldf-using-precompiled-sqlean-dll;

%stop_submissions;

Adding a superset of windows functions to r sqldf using precompiled sqlean dll

communities.sas (it appears that a one step solution was not presented)
https://tinyurl.com/3evfzb8j
https://communities.sas.com/t5/Statistical-Procedures/Calculate-mean-median-IQR-sum-sumpct/m-p/834703#M41340

PREP

 LOAD PRECOMPILED FUNCTIONS IN sqlean.dll
 ========================================

  I always create a restore point before downloading anything.

  https://github.com/nalgeon/sqlean/releases/tag/0.27.1
  download
  https://github.com/nalgeon/sqlean/releases/download/0.27.1/sqlean-win-x86.zip

  or
  https://tinyurl.com/3vet24f5
  https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories/blob/master/sqlean.dll

  or

  macros
  https://tinyurl.com/y9nfugth
  https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


  UNZIP INTO
  ==========

  d:/dll/sqlean.dll

  YOU ONLY NEED TO ADD ONE LINE TO YOUR SQLDF SCRIPT

  options(sqldf.dll = "d:/dll/sqlean.dll")


SAMPLE PROBLEM
==============

  Calculate mean, median, iqr, lab Sum divided by sum(Lab+Pham+Dia)

  SOAPBOX ON  (I hope I am correct?)
    Be skeptical, I have not tried all the SQL function below.
    Note: sas proc sql cannot compute the IQR or many of the functions below?
    I could not get the extentions to work in python pdsql.
    You may be able to add the extensions to a python external sqllite database,
    But I like tight integrations like sqldf and sas proc sql.
  SOAPBOX OFF

CATEGORIES OF ADDED FUNCTIONS FROM SQLEAN.DLL
=============================================

rypto       Hashing, encoding, and decoding data (e.g., MD5, SHA, Base64)
define      User-defined functions and dynamic SQL
fileio      File input/output (read/write files from SQL)
fuzzy       Fuzzy string matching and phonetics (e.g., soundex, metaphone)
ipaddr      IP address manipulation (IPv4/IPv6 parsing, conversion)
math        Mathematical functions (trigonometry, rounding, etc.)
regexp      Regular expressions (pattern matching)
stats       Statistical functions (median, percentiles, etc.)
text        Advanced string and Unicode functions
time        High-precision date/time functions
uuid        Universally Unique Identifier generat

/**************************************************************************************************************************************/
/*   NOTE SOME OF THESE FUNCTION ARE ONLY AVAILABLE ON THE SQLITE COMMAND LINE (IE MODE)                                              */
/*               name          define_free    json_group_array      math_ceil           radians            stddev       time_fmt_iso  */
/*                 ->              degrees   json_group_object       math_cos            random        stddev_pop      time_fmt_time  */
/*                ->>           dense_rank         json_insert      math_cosh        randomblob       stddev_samp           time_get  */
/*                abs           difference         json_object   math_degrees              rank             stdev       time_get_day  */
/*               acos         dlevenshtein          json_patch       math_exp          readfile         strfilter      time_get_hour  */
/*              acosh                dur_h         json_pretty     math_floor            regexp          strftime   time_get_isoweek  */
/*                age                dur_m          json_quote        math_ln    regexp_capture        string_agg   time_get_isoyear  */
/*               asin               dur_ms         json_remove       math_log       regexp_like            strpos    time_get_minute  */
/*              asinh               dur_ns        json_replace     math_log10    regexp_replace            substr     time_get_month  */
/*               atan                dur_s            json_set      math_log2     regexp_substr         substring      time_get_nano  */
/*              atan2               dur_us           json_type       math_mod            repeat           subtype    time_get_second  */
/*              atanh        edit_distance          json_valid        math_pi           replace               sum   time_get_weekday  */
/*               atn2               encode               jsonb       math_pow         replicate           symlink      time_get_year  */
/*                avg                 eval         jsonb_array   math_radians           reverse               tan   time_get_yearday  */
/*         bit_length                  exp       jsonb_extract     math_round             right              tanh         time_micro  */
/*             blake3        fileio_append   jsonb_group_array       math_sin          rightstr      text_bitsize         time_milli  */
/*               bm25         fileio_mkdir  jsonb_group_object      math_sinh             round     text_casefold          time_nano  */
/*              btrim          fileio_mode        jsonb_insert      math_sqrt        row_number       text_concat           time_now  */
/*           casefold          fileio_read        jsonb_object       math_tan              rpad     text_contains         time_parse  */
/*         caverphone       fileio_symlink         jsonb_patch      math_tanh          rsoundex        text_count         time_round  */
/*               ceil         fileio_write        jsonb_remove     math_trunc        rtreecheck   text_has_prefix         time_since  */
/*            ceiling          first_value       jsonb_replace            max        rtreedepth   text_has_suffix           time_sub  */
/*            changes                floor           jsonb_set            md5         rtreenode        text_index      time_to_micro  */
/*               char               format           julianday         median             rtrim         text_join      time_to_milli  */
/*        char_length       fts3_tokenizer                 lag            min       script_code   text_last_index       time_to_nano  */
/*   character_length                 fts5   last_insert_rowid          mkdir              sha1         text_left       time_to_unix  */
/*          charindex      fts5_get_locale          last_value            mod            sha256       text_length         time_trunc  */
/*           coalesce          fts5_locale                lead          .mode            sha384         text_like          time_unix  */
/*             concat       fts5_source_id                left          nlike            sha512        text_lower         time_until  */
/*          concat_ws          fuzzy_caver             leftstr         nlower              sign         text_lpad           timediff  */
/*                cos         fuzzy_damlev              length            now               sin        text_ltrim       to_timestamp  */
/*               cosh       fuzzy_editdist         levenshtein      nth_value              sinh       text_repeat              total  */
/*                cot        fuzzy_hamming                like          ntile           snippet      text_replace      total_changes  */
/*               coth        fuzzy_jarowin          likelihood         nullif           soundex      text_reverse          translate  */
/*              count          fuzzy_leven              likely         nupper        split_part        text_right           translit  */
/*      crypto_blake3        fuzzy_osadist                  ln   octet_length    sqlean_version         text_rpad               trim  */
/*      crypto_decode       fuzzy_phonetic      load_extension        offsets        sqlite_log        text_rtrim              trunc  */
/*      crypto_encode       fuzzy_rsoundex                 log       optimize  sqlite_source_id         text_size             typeof  */
/*         crypto_md5         fuzzy_script               log10   osa_distance    sqlite_version        text_slice           unaccent  */
/*        crypto_sha1        fuzzy_soundex                log2           padc              sqrt        text_split           undefine  */
/*      crypto_sha256       fuzzy_translit               lower           padl            square    text_substring              unhex  */
/*      crypto_sha384      gen_random_uuid      lower_quartile           padr       starts_with        text_title            unicode  */
/*      crypto_sha512                 glob                lpad   percent_rank      stats_median    text_translate    unicode_version  */
/*          cume_dist         group_concat              lsmode     percentile         stats_p25         text_trim          unixepoch  */
/*       current_date              hamming               ltrim  percentile_25         stats_p75        text_upper           unlikely  */
/*       current_time                  hex           make_date  percentile_75         stats_p90              time              upper  */
/*  current_timestamp            highlight      make_timestamp  percentile_90         stats_p95          time_add     upper_quartile  */
/*               date               ifnull               match  percentile_95         stats_p99     time_add_date              uuid4  */
/*           date_add                  iif           matchinfo  percentile_99        stats_perc        time_after              uuid7  */
/*          date_part                instr           math_acos  phonetic_hash      stats_stddev       time_before         uuid_blob   */
/*         date_trunc         jaro_winkler          math_acosh             pi  stats_stddev_pop      time_compare          uuid_str   */
/*           datetime                 json           math_asin            pow stats_stddev_samp         time_date           var_pop   */
/*             decode           json_array          math_asinh          power         stats_var        time_equal          var_samp   */
/*             define    json_array_length           math_atan         printf     stats_var_pop     time_fmt_date          variance   */
/*       define_cache  json_error_position          math_atan2         proper    stats_var_samp time_fmt_datetime         writefile   */
/*       json_extract           math_atanh          quote                                                                  zeroblob   */
/**************************************************************************************************************************************/

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/******************************************|*********************************************************************************/
/*         INPUT                           |                 PROCESS                    |                  OUTPUT           */
/*         =====                           |                 =======                    |                  ======           */
/*                                         |                                            |                                   */
/* options validvarname=upcase;            | CHECKING USING LAB VARIABLE                |                                   */
/* libname sd1 "d:/sd1";                   | ===========================                |                                   */
/*                                         |                                            |                                   */
/* data sd1.have(where=(not missing(val)));| Var    Val                                 | > want                            */
/* length caseid $10 Lab 3 Pham 4 Diag 4;  |                                            |                                   */
/* input Caseid Lab Pham Diag;             | lab    50                                  |  VAR  IQR      MEAN MEDIAN PCTLAB */
/*   var='lab ';val=lab;output;            | lab   100                                  |                                   */
/*   var='pham';val=pham;output;           | lab   200 lower_quartile                   | diag 4500 6450.0000  7000   0.00  */
/*   var='diag';val=diag;output;           | lab   360                                  |  lab  570  908.8889   500  10.65  */
/*   keep var val;                         | lab   500*middle                           | pham 5200 6114.2857  6000   0.00  */
/* cards4;                                 | lab   700                                  |                                   */
/* EC 200 6000 5500                        | lab   770 upper_quartile                   |                                   */
/* AC 100 7000 .                           | lab   900                                  |                                   */
/* EC 50  3800 .                           | lab  4600  mean  median iqr      pctlab    |                                   */
/* BH 4600 1500 .                          |            908.9   500  770-200  8180/76780|                                   */
/* EN 700 9000 2900                        |                           570    0.10653816|                                   */
/* CY 500 . .                              |                                            |                                   */
/* BH 900 5600 8500                        | WILL WORK IN EXCEL AND BUT NOT PYTHON      |                                   */
/* OP 360 9900 8900                        |                                            |                                   */
/* PC 770 . .                              | %utl_rbeginx;                              |                                   */
/* ;;;;                                    | parmcards4;                                |                                   */
/* run;quit;                               | library(haven)                             |                                   */
/*                                         | library(sqldf)                             |                                   */
/* Obs    VAR      VAL                     | source("c:/oto/fn_tosas9x.R")              |                                   */
/*                                         | options(sqldf.dll = "d:/dll/sqlean.dll")   |                                   */
/*   1    lab      200                     | have<-read_sas("d:/sd1/have.sas7bdat")     |                                   */
/*   2    pham    6000                     | print(have)                                |                                   */
/*   3    diag    5500                     | want<-sqldf('                              |                                   */
/*   4    lab      100                     |  select                                    |                                   */
/*   5    pham    7000                     |   var                                      |                                   */
/*   6    lab       50                     |   ,upper_quartile(val)-                    |                                   */
/*   7    pham    3800                     |      lower_quartile(val)         as iqr    |                                   */
/*   8    lab     4600                     |   ,avg(val)                      as mean   |                                   */
/*   9    pham    1500                     |   ,median(val)                   as median |                                   */
/*  10    lab      700                     |   ,100*sum((var="lab")*val)/               |                                   */
/*  11    pham    9000                     |      (select sum(val) from have) as pctlab |                                   */
/*  12    diag    2900                     |  from                                      |                                   */
/*  13    lab      500                     |       have                                 |                                   */
/*  14    lab      900                     |   group                                    |                                   */
/*  15    pham    5600                     |      by var                                |                                   */
/*  16    diag    8500                     |   ')                                       |                                   */
/*  17    lab      360                     | want                                       |                                   */
/*  18    pham    9900                     | ;;;;                                       |                                   */
/*  19    diag    8900                     | %utl_rendx;                                |                                   */
/*  20    lab      770                     |                                            |                                   */
/*                                         |                                            |                                   */
/*                                         |                                            |                                   */
/* proc sort data=sd1.have out=srt;        |                                            |                                   */
/* by var val;                             |                                            |                                   */
/* run;quit;                               |                                            |                                   */
/*                                         |                                            |                                   */
/*                                         |                                            |                                   */
/*  data sorted to check results           |                                            |                                   */
/*  data does not have to be sorted        |                                            |                                   */
/*                                         |                                            |                                   */
/*                                         |                                            |                                   */
/*  Var    Val                             |                                            |                                   */
/*                                         |                                            |                                   */
/*  lab    50                              |                                            |                                   */
/*  lab   100                              |                                            |                                   */
/*  lab   200 p25                          |                                            |                                   */
/*  lab   360                              |                                            |                                   */
/*  lab   500*middle                       |                                            |                                   */
/*  lab   700                              |                                            |                                   */
/*  lab   770 p75                          |                                            |                                   */
/*  lab   900                              |                                            |                                   */
/*  lab  4600                              |                                            |                                   */
/*                                         |                                            |                                   */
/*  mean  median iqr      pctlab           |                                            |                                   */
/*  908.9   500  770-200  8180/76780       |                                            |                                   */
/*                        0.10653816       |                                            |                                   */
/****************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have(where=(not missing(val)));
 input var$ val;
cards4;
lab 200
pham 6000
diag 5500
lab 100
pham 7000
lab 50
pham 3800
lab 4600
pham 1500
lab 700
pham 9000
diag 2900
lab 500
lab 900
pham 5600
diag 8500
lab 360
pham 9900
diag 8900
lab 770
;;;;
run;quit;

/**************************************************************************************************************************/
/*  VAR      VAL                                                                                                          */
/*                                                                                                                        */
/*  lab      200                                                                                                          */
/*  pham    6000                                                                                                          */
/*  diag    5500                                                                                                          */
/*  lab      100                                                                                                          */
/*  pham    7000                                                                                                          */
/*  lab       50                                                                                                          */
/*  pham    3800                                                                                                          */
/*  lab     4600                                                                                                          */
/*  pham    1500                                                                                                          */
/*  lab      700                                                                                                          */
/*  pham    9000                                                                                                          */
/*  diag    2900                                                                                                          */
/*  lab      500                                                                                                          */
/*  lab      900                                                                                                          */
/*  pham    5600                                                                                                          */
/*  diag    8500                                                                                                          */
/*  lab      360                                                                                                          */
/*  pham    9900                                                                                                          */
/*  diag    8900                                                                                                          */
/*  lab      770                                                                                                          */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll = "d:/dll/sqlean.dll")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
 select
  var
  ,upper_quartile(val)-
     lower_quartile(val)         as iqr
  ,avg(val)                      as mean
  ,median(val)                   as median
  ,sum((var="lab")*val)/
     (select sum(val) from have) as pctlab
 from
      have
  group
     by var
  ')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*  > want                                    |   SAS                                                                     */
/*     VAR  IQR      MEAN MEDIAN    PCTLAB    |   ROWNAMES    VAR      IQR      MEAN     MEDIAN     PCTLAB                */
/*                                            |                                                                           */
/*  1 diag 4500 6450.0000   7000 0.0000000    |       1       diag    4500    6450.00     7000      0.000                 */
/*  2  lab  570  908.8889    500 0.1065382    |       2       lab      570     908.89      500     10.654                 */
/*  3 pham 5200 6114.2857   6000 0.0000000    |       3       pham    5200    6114.29     6000      0.000                 */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
