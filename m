From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 21:21:30 +0800
Subject: [PATCH 0/4] crypto: caam - add Job Ring support for DPAA2 parts
In-Reply-To: <20170718153050.15330-1-horia.geanta@nxp.com>
References: <20170718153050.15330-1-horia.geanta@nxp.com>
Message-ID: <20170725132129.GB29754@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 06:30:46PM +0300, Horia Geant? wrote:
> This patch set adds support for CAAM's legacy Job Ring backend / interface
> on platforms having DPAA2 (Datapath Acceleration Architecture v2), like
> LS1088A or LS2088A.
> 
> I would like to get the DT patches through the crypto list (to make sure
> they don't end up merged before driver support).

Unless it's really urgent (usually critical bug fix), the DTS patches
should go through arm-soc tree.  We usually take DTS patches after the
driver counterpart has been accepted by subsystem maintainers, or in the
best case, has landed on mainline.

Shawn
