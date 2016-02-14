From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 15:42:18 +0800
Subject: [PATCH] ARM: dts: ls2080a: Add quirk for Erratum A009116
In-Reply-To: <1455059287-2500-1-git-send-email-Lijun.Pan@freescale.com>
References: <1455059287-2500-1-git-send-email-Lijun.Pan@freescale.com>
Message-ID: <20160214074218.GL6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 05:08:07PM -0600, Lijun Pan wrote:
> Add "snps,quirk-frame-length-adjustment" property to
> USB3 node for erratum A009116. This property provides
> value of GFLADJ_30MHZ for post silicon frame length
> adjustment.
> 
> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>

Applied, thanks.
