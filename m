From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 19:36:16 +0800
Subject: [PATCH] ARM: dts: imx: add "jedec,spi-nor" flash compatible
 binding
In-Reply-To: <1439707157-15091-1-git-send-email-zajec5@gmail.com>
References: <1439707157-15091-1-git-send-email-zajec5@gmail.com>
Message-ID: <20150906113615.GO30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 16, 2015 at 08:39:17AM +0200, Rafa? Mi?ecki wrote:
> Starting with commit 8947e396a829 ("Documentation: dt: mtd: replace
> "nor-jedec" binding with "jedec, spi-nor"") we have "jedec,spi-nor"
> binding indicating support for JEDEC identification.
> 
> Use it for all flashes that are supposed to support READ ID op according
> to the datasheets.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied, thanks.
