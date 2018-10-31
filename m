From: horms@verge.net.au (Simon Horman)
Date: Wed, 31 Oct 2018 15:34:06 +0100
Subject: [PATCH 2/4] arm64: renesas_defconfig: Enable scu-simple-card
 driver
In-Reply-To: <20181015095924.25794-3-horms+renesas@verge.net.au>
References: <20181015095924.25794-1-horms+renesas@verge.net.au>
 <20181015095924.25794-3-horms+renesas@verge.net.au>
Message-ID: <20181031143406.4wysyxz5fd34d5r6@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 11:59:22AM +0200, Simon Horman wrote:
> Enable the scu-simple-card which is used by
> the R-Car E3 (r8a77990) based Ebisu board.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> N.B: This is targeted at the devel branch of the renesas tree
> but not upstream where renesas_defconfig does not currently exist

Applied to topic/renesas-defconfig, which is included in the devel
branch but not targeted at upstream.
