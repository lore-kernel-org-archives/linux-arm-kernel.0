From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Mar 2018 16:17:11 +0800
Subject: [PATCH] ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name
In-Reply-To: <ca6bd71c64691209cae279e2c094ce511a9e7419.1519908633.git.leonard.crestez@nxp.com>
References: <ca6bd71c64691209cae279e2c094ce511a9e7419.1519908633.git.leonard.crestez@nxp.com>
Message-ID: <20180308081710.GR3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 02:52:08PM +0200, Leonard Crestez wrote:
> The two usb-otg regulators for imx7d-sdb are both called
> "regulator-usb-otg1-vbus" and they effectively override each other.
> 
> This is most likely a copy-paste error.
> 
> Fixes: b877039aa1fe ("ARM: dts: imx7d-sdb: Adjust the regulator nodes")
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
