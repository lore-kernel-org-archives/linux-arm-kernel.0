From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 02 Mar 2016 22:46:38 +0100
Subject: [PATCH] arm: dts: rockchip: remove broken-cd from emmc and sdio
In-Reply-To: <1453774003-10184-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453774003-10184-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <4368799.D9H4RyoZdr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. Januar 2016, 10:06:43 schrieb Shawn Lin:
> Only one of "broken-cd" and "non-removable" should be supplied
> according to Documentation/devicetree/bindings/mmc/mmc.txt.
> Obviously emmc and sdio-wifi are non-removable devices, while
> broken-cd is for removable device whose card detect pin is broken.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

applied to my dts32 branch

Thanks
Heiko
