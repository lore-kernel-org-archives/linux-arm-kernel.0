From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 8 Jan 2010 10:44:24 +0100
Subject: Module Compilation Error in linux-2.6.15  using floating point
In-Reply-To: <4B46FC7E.9050406@cdotb.ernet.in>
References: <4B46FC7E.9050406@cdotb.ernet.in>
Message-ID: <19270.65144.480771.919712@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>          I am using arm9 based fujitsu card . I have compiled and ported linux-2.6.15 
> with eldk4.2. I am trying to insert a module in which I am using floating point operations.
> 
> While compiling this module , the following errors occur :
> 
> *** Warning: "__subdf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__gedf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__truncdfsf2" 
> [/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
> *** Warning: "__ltsf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__muldf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__divdf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__ledf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__gtsf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__floatunsidf" 
> [/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
> *** Warning: "__adddf3" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__extendsfdf2" 
> [/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
> *** Warning: "__fixunsdfsi" 
> [/export/home1/suchita/bws_linux/bws_menu.ko] undefined!
> *** Warning: "__ltdf2" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> *** Warning: "__floatsidf" [/export/home1/suchita/bws_linux/bws_menu.ko] 
> undefined!
> 
> Please suggest a solution to overcome these errors.
>
Don't use floating point in the kernel.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
