From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 15 Apr 2015 21:11:32 +0200 (CEST)
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix dr_mode of usb0
In-Reply-To: <20150415033211.GB29095@shlinux2>
References: <1429043846-28731-1-git-send-email-stefan.wahren@i2se.com>
 <20150415033211.GB29095@shlinux2>
Message-ID: <772352469.13551.1429125092786.JavaMail.open-xchange@oxbaltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> Peter Chen <peter.chen@freescale.com> hat am 15. April 2015 um 05:32
> geschrieben:
>
>
> [...]
>
> If this board has only host function, I am ok for it.

Yes, all 4 boards (Maxi [1], Micro [2], Mini [3], Nano [4]) have only host
function.

>
> Acked-by: Peter Chen <peter.chen@freescale.com>

Thanks
Stefan

[1] -
https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/iMX233-OLinuXino-Maxi/iMX233-OLINUXINO-MAXI_Rev_D.pdf
[2] -
https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/iMX233-OLinuXino-Micro/iMX233-OLinuXino-Micro_Rev_D.pdf
[3] -
https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/iMX233-OLinuXino-Mini/iMX233-OLINUXINO-MINI_Rev_C.sch.pdf
[4] -
https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/iMX233-OLinuXino-NANO/iMX233-OLinuXino-NANO_Rev_B.pdf

>
> --
>
> Best Regards,
> Peter Chen
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
