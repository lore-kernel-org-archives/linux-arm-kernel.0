From: b32955@freescale.com (Huang Shijie)
Date: Sat, 31 Dec 2011 15:27:36 +0800
Subject: [PATCH] MTD/GPMI : select more modules for GPMI by default
In-Reply-To: <20111231072441.GF12182@S2100-06.ap.freescale.net>
References: <1325220337-23165-1-git-send-email-b32955@freescale.com>
 <20111231054432.GE12182@S2100-06.ap.freescale.net>
 <4EFEA210.30606@freescale.com>
 <20111231072441.GF12182@S2100-06.ap.freescale.net>
Message-ID: <4EFEB968.2000905@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks a lot!
> Here is what Documentation/kbuild/kconfig-language.txt tells:
>
>          select should be used with care. select will force
>          a symbol to a value without visiting the dependencies.
:( I ever thought the select will do the dependencies automatically.


I do not like the GPMI depend on the MXS-DMA. It looks very strange when 
you do the "make menuconfig".

to Arterm:
   Maybe you can drop this patch.

thanks

Huang Shijie
>          By abusing select you are able to select a symbol FOO even
>          if FOO depends on BAR that is not set.
>          In general use select only for non-visible symbols
>          (no prompts anywhere) and for symbols with no dependencies.
>          That will limit the usefulness but on the other hand avoid
>          the illegal configurations all over.
>
