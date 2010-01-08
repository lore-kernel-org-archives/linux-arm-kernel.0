From: jyothi@cdotb.ernet.in (jyothi)
Date: Fri, 08 Jan 2010 15:05:58 +0530
Subject: Module Compilation Error in linux-2.6.15  using floating point
Message-ID: <4B46FC7E.9050406@cdotb.ernet.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ,
         I am using arm9 based fujitsu card . I have compiled and ported linux-2.6.15 
with eldk4.2. I am trying to insert a module in which I am using floating point operations.

While compiling this module , the following errors occur :

*** Warning: "__subdf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__gedf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__truncdfsf2" 
[/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
*** Warning: "__ltsf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__muldf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__divdf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__ledf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__gtsf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__floatunsidf" 
[/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
*** Warning: "__adddf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__extendsfdf2" 
[/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
*** Warning: "__fixunsdfsi" 
[/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
*** Warning: "__ltdf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!
*** Warning: "__floatsidf" [/export/home1/suchita/bws_linux/bws_menu.ko] 
undefined!

Please suggest a solution to overcome these errors.
Thanks in advance.


Regards,
Jyothi
