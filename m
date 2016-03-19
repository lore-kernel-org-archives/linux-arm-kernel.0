From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 Mar 2016 09:31:08 +0100
Subject: [PATCH v2] ARM: rockchip: Fix use of plain integer as NULL pointer
In-Reply-To: <1458222191-26023-1-git-send-email-peter.griffin@linaro.org>
References: <1458222191-26023-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1774724.ZvGCkNYnIY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. M?rz 2016, 13:43:11 schrieb Peter Griffin:
> This fixes the following sparse build warning:
> 
>      mach-rockchip/platsmp.c:68:43: Using plain integer as NULL pointer
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

applied to soc32-fixes for 4.6 with Lee's Ack


Thanks
Heiko
