From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 15 Jun 2013 22:41:24 +0200
Subject: [GIT PULL 3/5]: ux500 pinctrl changes for v3.11
In-Reply-To: <20130615002029.GH18124@quad.lixom.net>
References: <CACRpkdbFs=pX+Yc8EzgVyi-k5HypkHO9jMGMU+VkYfRYyinDSA@mail.gmail.com>
 <20130615000215.GD18124@quad.lixom.net>
 <20130615002029.GH18124@quad.lixom.net>
Message-ID: <CACRpkdYwXGfMFaMN_Zsy5Wb18s7D2p_KE72erFAa4PLUa8RQKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 2:20 AM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Jun 14, 2013 at 05:02:15PM -0700, Olof Johansson wrote:
>> On Tue, Jun 04, 2013 at 02:25:39PM +0200, Linus Walleij wrote:

>> > ----------------------------------------------------------------
>> > Ux500 pinctrl changes:
>> > - Updates to MSP pinctrl entry for ALSA SoC
>> > - ABx500 pinctrl tables
>> >
>> > ----------------------------------------------------------------

>> Pulled.
>
> Hmm. u8500_defconfig:
>
> arch/arm/mach-ux500/board-mop500-pins.c:51:6: warning: 'slpm_in_nopull_wkup' defined but not used [-Wunused-variable]
> arch/arm/mach-ux500/board-mop500-pins.c:63:6: warning: 'slpm_out_lo_wkup' defined but not used [-Wunused-variable]

I wonder if that warning was not there before this patch set as well?
Oh well, we shouldn't have them...

> I've checked in the following on top:
>
>
> From e1e16a4e7696add0c444a1f8766f6269d219a72b Mon Sep 17 00:00:00 2001
> From: Olof Johansson <olof@lixom.net>
> Date: Fri, 14 Jun 2013 17:15:12 -0700
> Subject: [PATCH] ARM: ux500: board-mop500: remove unused pin modes
>
> Removes the following warnings:
>
> arch/arm/mach-ux500/board-mop500-pins.c:51:6: warning: 'slpm_in_nopull_wkup' defined but not used [-Wunused-variable]
> arch/arm/mach-ux500/board-mop500-pins.c:63:6: warning: 'slpm_out_lo_wkup' defined but not used [-Wunused-variable]
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Linus Walleij <linux.walleij@linaro.org>

Thanks.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
