From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 25 Aug 2017 11:34:35 +0200
Subject: [PATCH v2 1/3] arm64: dts: rockchip: add mmc nodes for rk3328
 evaluation board
In-Reply-To: <1503542223-21044-2-git-send-email-cl@rock-chips.com>
References: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
 <1503542223-21044-2-git-send-email-cl@rock-chips.com>
Message-ID: <4430314.yE5BBxJgsD@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. August 2017, 10:37:01 CEST schrieb cl at rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> Rockchip's rk3328 evaluation board has 3 mmc controllers for
> sdio/sdmmc/emmc, let's enable them.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied ... but I cannot say if it will still be eligible for 4.14
(late in the cycle). If necessary I'll move it forward a release.

Thanks
Heiko
