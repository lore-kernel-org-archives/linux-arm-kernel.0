From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Sep 2016 12:53:04 +0200
Subject: [PATCH] arm64: dts: rockchip: Add pinctrl entry for 32k clock on
 rk3399
In-Reply-To: <1472774002-25986-1-git-send-email-dianders@chromium.org>
References: <1472774002-25986-1-git-send-email-dianders@chromium.org>
Message-ID: <3854560.94E0h0U25i@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. September 2016, 16:53:22 schrieb Douglas Anderson:
> On some rk3399 boards GPIO0_A0 is hooked up to a 32 kHz clock.  This can
> be used as the source for various clocks in the system.
> 
> Add a pinmux so boards can get this pin properly configured.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied to my dts64 branch for 4.9


Thanks
Heiko
