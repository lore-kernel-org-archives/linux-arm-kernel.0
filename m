From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 09 Sep 2017 01:45:53 +0200
Subject: [PATCH v8 2/3] ARM: dts: Add LVDS info for rk3288
In-Reply-To: <1504351732-135989-1-git-send-email-hjc@rock-chips.com>
References: <1504351723-135876-1-git-send-email-hjc@rock-chips.com>
 <1504351732-135989-1-git-send-email-hjc@rock-chips.com>
Message-ID: <35833616.zLl8rNldH8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 2. September 2017, 19:28:52 CEST schrieb Sandy Huang:
> add LVDS info in rk3288.dtsi for LVDS driver
> This based on the patches from Mark yao and Heiko Stuebner.
> 
> Signed-off-by: Mark yao <mark.yao@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

applied for 4.15 after moving both the lvds node to its correct
position (please always sort by address) and fixed the register
addressing to honor the recent rk3288 64bit conversion.


Heiko
