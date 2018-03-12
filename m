From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Mar 2018 15:24:08 +0800
Subject: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
In-Reply-To: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
Message-ID: <20180312072406.GL3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 10:58:19PM +0100, Martin Kaiser wrote:
> According to the i.MX25 reference manuals, each SSI has four FIFOs. All
> of those FIFOs can store up to 15 entries.
> 
> The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
> non-default FIFO depth explicitly in the Device Tree.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
