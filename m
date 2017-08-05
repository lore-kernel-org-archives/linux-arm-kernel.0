From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Aug 2017 09:54:45 +0800
Subject: [PATCH 0/4] crypto: caam - add Job Ring support for DPAA2 parts
In-Reply-To: <20170718153050.15330-1-horia.geanta@nxp.com>
References: <20170718153050.15330-1-horia.geanta@nxp.com>
Message-ID: <20170805015444.GN31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 06:30:46PM +0300, Horia Geant? wrote:
> This patch set adds support for CAAM's legacy Job Ring backend / interface
> on platforms having DPAA2 (Datapath Acceleration Architecture v2), like
> LS1088A or LS2088A.
> 
> I would like to get the DT patches through the crypto list (to make sure
> they don't end up merged before driver support).
> 
> Thanks,
> Horia
> 
> Horia Geant? (4):
>   crypto: caam/jr - add support for DPAA2 parts
>   arm64: dts: freescale: ls208xa: share aliases node
>   arm64: dts: freescale: ls208xa: add crypto node
>   arm64: dts: freescale: ls1088a: add crypto node

Applied 3 dts patches, thanks.
