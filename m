From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 13 Dec 2015 01:47 +0100
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add the needed timer for
 RK3368 SoC
In-Reply-To: <1443147298-12603-5-git-send-email-wxt@rock-chips.com>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
 <1443147298-12603-5-git-send-email-wxt@rock-chips.com>
Message-ID: <1937886.TSnbmHXrLV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 25. September 2015, 10:14:58 schrieb Caesar Wang:
> There is a need of a broadcast timer in this case to ensure proper
> wakeup when the cpus are in sleep mode and a timer expires.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied this patch to my dts64 branch for 4.5 .

The Kconfig option will probably need to wait for 4.6 though, due to the 
clocksource change going through Daniel's tree. Or I'll try to submit that 
post 4.5-rc1 as "fix" ... we'll see.


Heiko
