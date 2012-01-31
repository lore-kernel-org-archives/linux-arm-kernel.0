From: b32955@freescale.com (Huang Shijie)
Date: Tue, 31 Jan 2012 16:47:20 +0800
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120130114131.GC15596@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130094610.GA15596@pengutronix.de> <4F2671C3.6000809@freescale.com>
 <20120130104428.GB15596@pengutronix.de> <4F267F21.1030204@freescale.com>
 <20120130114131.GC15596@pengutronix.de>
Message-ID: <4F27AA98.2090602@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
> CCing Marek, he can say more about the U-Boot side probably...
>
>>> Bootloaders may also need to write to NAND. So, they need to share the
>> Do you mean the uboot may write something to the NAND?
>> Could you show me some more detail cases?
> U-Boot has NAND support in mainline, for barebox it is work-in-progress.
> Both can and do write to NAND (kernel, rootfs), because both have
> established procedures to do so (and maybe don't want to rely on
> third-party tools like kobs-ng).
>
ok.

What's about to add a module_param() to enable/disable the BBT for GPMI?
What's your suggestion?


Br
Huang Shijie
