From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 24 Oct 2017 15:37:33 +0200
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add efuse for RK3368 SoCs
In-Reply-To: <20170904085119.25981-5-romain.perier@collabora.com>
References: <20170904085119.25981-1-romain.perier@collabora.com>
 <20170904085119.25981-5-romain.perier@collabora.com>
Message-ID: <5744497.0PmpLyO0rR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 4. September 2017, 10:51:19 CEST schrieb Romain Perier:
> This adds the definition for eFuse that is found on RK3368 SoCs with the
> corresponding data cells.
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

applied for 4.15 after the following changes
- moved efuse node to its correct position (determined by register address)
- use correct clock-id as added by patch1 (efuse256 without the underscore)
- added the #address- and #size-cells properties for the subnodes
  to make dtc happy

Please pay a bit more attention for future patches.


Thanks
Heiko
