From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 May 2018 14:45:12 +0800
Subject: [PATCH] arm64: dts: fsl-ls1012a: Fix DTC aliases warnings
In-Reply-To: <1525694564-15203-1-git-send-email-festevam@gmail.com>
References: <1525694564-15203-1-git-send-email-festevam@gmail.com>
Message-ID: <20180515064511.GK26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 09:02:44AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Use '-' instead of '_' to fix the following DTC warnings with W=1:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> 
> Cc: Harninder Rai <harninder.rai@nxp.com>
> Cc: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
