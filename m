From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 May 2018 08:59:32 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable RENESAS_WDT
In-Reply-To: <20180502094353.27488-1-horms+renesas@verge.net.au>
References: <20180502094353.27488-1-horms+renesas@verge.net.au>
Message-ID: <20180516065931.amccl5sr7i6dengd@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 11:43:53AM +0200, Simon Horman wrote:
> R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
> its driver by default. It is enabled as a module to avoid increasing
> the kernel image size.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied.
