From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 02 Mar 2016 22:46:50 +0100
Subject: [PATCH] arm64: dts: rockchip: remove broken-cd from emmc and sdio
In-Reply-To: <1453774019-10225-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453774019-10225-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1583449.b52WQDyKXa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. Januar 2016, 10:06:59 schrieb Shawn Lin:
> Only one of "broken-cd" and "non-removable" should be supplied
> according to Documentation/devicetree/bindings/mmc/mmc.txt.
> Obviously emmc and sdio-wifi are non-removable devices, while
> broken-cd is for removable device whose card detect pin is broken.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

applied to my dts32 branch

Thanks
Heiko
