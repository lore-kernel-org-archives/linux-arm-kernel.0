From: marex@denx.de (Marek Vasut)
Date: Sat, 26 May 2012 13:37:59 +0200
Subject: [PATCH v3 00/12] add imx usb driver for mx28/6x
In-Reply-To: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <201205261337.59500.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> The work is based on  ci13xxx rework done by Alexander Shishkin.
> 
> Status:
>   - this version only support host
>   - usbotg controler works at host role
> 
> Changes since V2:
>   - Rebase to Alex's tree
>   - Use regulator to control vbus power
>   - Remove ARCH check in Kconfig, but add OF_DEV check.
>   - Other changes according laster version comments.

Is there any git tree with these patches? Also, on top of what tree are these 
based on please?

Thanks!

Best regards,
Marek Vasut
