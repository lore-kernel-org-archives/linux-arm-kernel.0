From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 09 Nov 2016 15:37:17 +0100
Subject: [PATCH 12/13] ARM64: dts: rockchip: replace to "max-frequency"
 instead of "clock-freq-min-max"
In-Reply-To: <20161103062135.10697-13-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-13-jh80.chung@samsung.com>
Message-ID: <8752381.WGgomIQVST@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. November 2016, 15:21:34 CET schrieb Jaehoon Chung:
> In drivers/mmc/core/host.c, there is "max-freqeuncy" property.
> It should be same behavior, So Use the "max-frequency" instead of
> "clock-freq-min-max".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

applied to my dts64 branch for 4.10


Thanks
Heiko
