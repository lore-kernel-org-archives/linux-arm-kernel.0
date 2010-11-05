From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 5 Nov 2010 14:29:46 +0200
Subject: Single binary kernel for all i.MX
In-Reply-To: <20101105121800.GV6017@pengutronix.de>
References: <20101105121800.GV6017@pengutronix.de>
Message-ID: <20101105122946.GH13530@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, Nov 05, 2010 at 01:18:00PM +0100, Sascha Hauer wrote:
> We are talking about a single kernel for longer now, here is something
> to test for the ones interested:
> 
> git://git.pengutronix.de/git/imx/linux-2.6.git imx-single-kernel
> 
> Compiling the imx_defconfig will result in a kernel which works
> i.MX21, i.MX27, i.MX31, i.MX35 and i.MX51 (not tested on i.MX21).
> i.MX1 does not work mainly because the kernel build will use some ARMv5
> and later instructions.

What is blocking i.MX25 from being included?

baruch

> The branch is based on the patches recently posted. It contains some
> hacks, so it still needs to be worked on.
> 
> Sascha

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
