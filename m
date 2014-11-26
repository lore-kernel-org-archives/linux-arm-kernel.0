From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 26 Nov 2014 01:45:12 +0100
Subject: [PATCH 1/2] clk: rockchip: add binding ID for DMC (memory
 controller) clocks on rk3288
In-Reply-To: <1416960783-25119-1-git-send-email-dianders@chromium.org>
References: <1416960783-25119-1-git-send-email-dianders@chromium.org>
Message-ID: <1717801.sWHeWsmqUi@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 25. November 2014, 16:13:02 schrieb Doug Anderson:
> From: Jeff Chen <cym@rock-chips.com>
> 
> The DMC clocks need to be turned off at runtime, so we should have IDs
> so we can export them.
> 
> Signed-off-by: Jeff Chen <cym@rock-chips.com>
> [dianders: split into two patches; adjusted commit msg]
> Signed-off-by: Doug Anderson <dianders@chromium.org>

both patches look ok to me and I'll probably pick them up tomorrow.

Just as handling question, do you plan on sending dts changes using these 
clocks in time for 3.19 [i.e. in the next couple of days]?

We have currently three clock patches/series adding new clock ids [this one, 
the mmc phases and Sonny's i2s_clkout] and I'm trying to dertermine if I need 
a shared branch for those.

Currently it doesn't look like the others will provide dts patches using the 
clocks in time, so it looks like I can skip the shared branch and we can use 
the clock ids regularly after the merge-window. Some true for your clocks?


Thanks
Heiko
