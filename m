From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Sep 2018 23:33:48 +0800
Subject: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
In-Reply-To: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180925153345.GA22238@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 04:13:29PM +0800, Anson Huang wrote:
> Update VDD_SOC voltage to 1.25V for 900MHz operating point
> according to datasheet Rev. 1.3, 08/2018, 25mV is added to
> the minimum allowed values to cover power supply ripple.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
