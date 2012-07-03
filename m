From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 18:39:14 +0800
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add watchdog support
In-Reply-To: <20120703101744.GW2698@pengutronix.de>
References: <1341258627-3469-1-git-send-email-festevam@gmail.com>
 <20120703030337.GD22106@S2101-09.ap.freescale.net>
 <20120703101744.GW2698@pengutronix.de>
Message-ID: <CAAQ0ZWSerqd-2RsZv4tsxOVUAHhrALSGY9dz9fKifogYtgfupw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 July 2012 18:17, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> I'm not so sure about the rtc though, since one important component of
> the RTC is not completely internal to the SoC: the battery.
>
Yes, that the case, practically.  But technically, even without
battery, RTC can also be useful for a system if only warm reset will
be performed.

Regards,
Shawn
