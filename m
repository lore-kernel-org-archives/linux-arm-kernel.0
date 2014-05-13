From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 May 2014 09:54:33 +0800
Subject: [PATCH v5 2/2] ARM: dts: mx51: Remove mach-cpuimx51sd board file
In-Reply-To: <1399736856-9489-2-git-send-email-festevam@gmail.com>
References: <1399736856-9489-1-git-send-email-festevam@gmail.com>
 <1399736856-9489-2-git-send-email-festevam@gmail.com>
Message-ID: <20140513015431.GI8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 10, 2014 at 12:47:36PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> eukrea_mbimxsd51-baseboard.c and mach-cpuimx51sd.c can be replaced with their
> devicetree equivalents: imx51-eukrea-mbimxsd51-baseboard.dts and 
> imx51-eukrea-cpuimx51.dtsi respectively, so remove the board files.
> 
> This allows the conversion of mx51 to a devicetree-only platform.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This is not a dts patch, so I dropped 'dts' from patch prefix.

Applied both, thanks.
