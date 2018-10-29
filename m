From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Oct 2018 11:22:57 +0100
Subject: [PATCH] arm64: renesas_defconfig: Enable R-Car thermal driver
In-Reply-To: <20181017100722.29481-1-horms+renesas@verge.net.au>
References: <20181017100722.29481-1-horms+renesas@verge.net.au>
Message-ID: <20181029102257.csg7i2fucsa6urlb@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:07:22PM +0200, Simon Horman wrote:
> Enable the R-Car thermal driver.
> 
> This driver is used in conjunction with the R-Car V3M (r8a77970),
> E3 (r8a77990) and D3 (r8a77995) SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> N.B: This is targeted at the devel branch of the renesas tree
> but not upstream where renesas_defconfig does not currently exist

Applied to the topic/renesas_defconfig branch of the renesas tree
which is carried in the devel branch of the same tree but not
targeted at upstream.
