From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 15:31:50 +0800
Subject: [PATCH] ARM: dts: imx6ul: add pm_power_off support
In-Reply-To: <1438957713-27661-1-git-send-email-b20788@freescale.com>
References: <1438957713-27661-1-git-send-email-b20788@freescale.com>
Message-ID: <20150906073150.GH30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 10:28:33PM +0800, Anson Huang wrote:
> i.MX6UL can be powered off by programming SNVS.
> 
> When long press ON/OFF button(5 seconds),
> PMIC_ON_REQ pin will be set to low and external
> PMIC will be powered off.
> 
> And system can be powered on by long press ON/OFF
> button again.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
