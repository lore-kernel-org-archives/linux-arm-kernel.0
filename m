From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 19:54:04 +0800
Subject: [PATCH] ARM: dts: imx6dl: Fix the VDD_ARM_CAP voltage for 396MHz
 operation
In-Reply-To: <1461616637-24717-1-git-send-email-festevam@gmail.com>
References: <1461616637-24717-1-git-send-email-festevam@gmail.com>
Message-ID: <20160426115404.GB30692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 05:37:17PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Table 8 from MX6DL datasheet (IMX6SDLCEC Rev. 5, 06/2015):
> http://cache.nxp.com/files/32bit/doc/data_sheet/IMX6SDLCEC.pdf
> 
> states the following:
> 
> "LDO Output Set Point (VDD_ARM_CAP) = 1.125 V minimum for operation
> up to 396 MHz."
> 
> So fix the entry by adding the 25mV margin value as done in the other
> entries of the table, which results in 1.15V for 396MHz operation.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
