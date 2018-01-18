From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Jan 2018 20:56:25 +0530
Subject: [PATCH v5 33/44] ARM: davinci: switch to common clock framework
In-Reply-To: <1515378238-23105-4-git-send-email-david@lechnology.com>
References: <1515378238-23105-1-git-send-email-david@lechnology.com>
 <1515378238-23105-4-git-send-email-david@lechnology.com>
Message-ID: <6a694c9e-243a-5fce-03fa-989d8bb783d2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:53 AM, David Lechner wrote:
> diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
> index 4e81780..8a8f413 100644
> --- a/arch/arm/mach-davinci/Makefile
> +++ b/arch/arm/mach-davinci/Makefile
> @@ -5,7 +5,7 @@
>  #
>  
>  # Common objects
> -obj-y 			:= time.o clock.o serial.o psc.o \
> +obj-y 			:= time.o serial.o \
>  			   usb.o common.o sram.o aemif.o

The line break seems too early now.

Thanks,
Sekhar
