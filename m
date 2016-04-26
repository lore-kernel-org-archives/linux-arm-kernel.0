From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 19:52:45 +0800
Subject: [PATCH 1/2] ARM: dts: imx6ul: Fix operating points
In-Reply-To: <1461613128-24001-1-git-send-email-festevam@gmail.com>
References: <1461613128-24001-1-git-send-email-festevam@gmail.com>
Message-ID: <20160426115244.GA30692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 04:38:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Adjust the VDD_ARM_CAP and VDD_SOC_CAP voltages according to 
> Table-11 from MX6UL datasheet:
> http://cache.nxp.com/files/32bit/doc/data_sheet/IMX6ULCEC.pdf
> 
> (a 25mV offset is added to the minimum allowed values for safety).
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
