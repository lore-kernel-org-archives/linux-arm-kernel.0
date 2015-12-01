From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 02 Dec 2015 00:50:29 +0100
Subject: [PATCH 0/3] Add the rk3368 evb board with the act8846 pmic
In-Reply-To: <1448961206-23769-1-git-send-email-wxt@rock-chips.com>
References: <1448961206-23769-1-git-send-email-wxt@rock-chips.com>
Message-ID: <5501370.GQCpicsLkL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Dienstag, 1. Dezember 2015, 17:13:23 schrieb Caesar Wang:
> This series pacthes try to add the evb dts for rk3368 SoCs,
> This's similar with the rj3288 evb board.
> 
> On the moment, pwm/backlight/usb/thermal/emmc stuff can work for this
> board, I add the base version for the future firstly.
applied all 3 to relevant branches for 4.5, with some small changes:

> PATCH [1/3]: Force rk3368 PWM clock (and its parents) On
> That's similar HACK way to work.
shortened the comment in the code a bit

> PATCH [2/3]: Add the RK3368 EVB board for with the act8846 pmic for dtsi
Moved some minor stuff around a bit (ordering, etc)

> PATCH [3/3]: Add the PWM node info for rk3368 core.
this now comes before the addition of the evb files


Heiko
