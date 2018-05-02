From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 May 2018 11:38:21 +0200
Subject: [PATCH v5 14/26] ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
In-Reply-To: <1518457475-4480-15-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-15-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180502093821.m276vxqixob47e4p@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:44:23PM +0000, Fabrizio Castro wrote:
> R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
> its driver by default.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied.
