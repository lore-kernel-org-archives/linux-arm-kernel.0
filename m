From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Aug 2014 18:11:13 +0200
Subject: [PATCH] ARM: dts: Move the PMIC interrupt pinctrl line to
 rk3288-evb common
In-Reply-To: <1407782849-11056-1-git-send-email-dianders@chromium.org>
References: <1407782849-11056-1-git-send-email-dianders@chromium.org>
Message-ID: <2248839.hV1QilfnQh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 11. August 2014, 11:47:29 schrieb Doug Anderson:
> The PMIC interrupt pinctrl line was added to the rk3288-evb-act8846,
> but it's the same line on both the ACT8846 version and the RK808
> version.  This makes a lot of sense since they share the same SoC
> daugherboard.  Move the pinctrl definition to the common file so we
> can use it for the RK808 version.
> 
> NOTE: The PMIC interrupt doesn't _actually_ go to the PMIC on the
> ACT8846 version of the board (it does on the RK808), but our
> convention is to label things as they're labelled on the schematics.
> In the very least you can argue that this is the interrupt from the
> PMIC daughtercard even if it doesn't actually go to the PMIC chip.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

I've added this to my v3.18 dts branch


Heiko
