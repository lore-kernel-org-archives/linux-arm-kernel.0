From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Fri, 7 Jun 2013 01:29:27 +0000
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <20130606200519.GA1644@kroah.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <20130606200519.GA1644@kroah.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CFC11@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>This breaks the build on x86 systems with:
>  CC [M]  drivers/tty/serial/fsl_lpuart.o
>drivers/tty/serial/fsl_lpuart.c: In function ?lpuart_probe?:
>drivers/tty/serial/fsl_lpuart.c:751:2: error: implicit declaration of
>function ?of_alias_get_id? [-Werror=implicit-function-declaration]
>
[Lu Jingchang-B35083] 
I will send the v7 patch with this error fixed. Thanks!
 
