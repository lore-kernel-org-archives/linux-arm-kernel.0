From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 17:09:53 +0800
Subject: [PATCH] ARM: dts: imx50: remove non-existent USB instances
In-Reply-To: <20180624061538.10156-1-akurz@blala.de>
References: <20180624061538.10156-1-akurz@blala.de>
Message-ID: <20180701090952.GM4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2018 at 06:15:38AM +0000, Alexander Kurz wrote:
> According to the i.MX50 Reference Manual, the SoC features one USB OTG
> and one host controller. Remove the non-existent instances from the
> DTS which probably got initially copied from the mx53 DTS.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>

Applied, thanks.
