From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 20 Jan 2016 09:47:54 +0100
Subject: [PATCH 2/4] net: mvneta: Try to get named core clock first
In-Reply-To: <1453277183-5412-3-git-send-email-jszhang@marvell.com>
References: <1453277183-5412-1-git-send-email-jszhang@marvell.com>
 <1453277183-5412-3-git-send-email-jszhang@marvell.com>
Message-ID: <20160120094754.316390b5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jisheng Zhang,

On Wed, 20 Jan 2016 16:06:21 +0800, Jisheng Zhang wrote:
> Some platforms may provide more than one clk for the mvneta IP, for
> example Marvell BG4CT provides "core" clk for the mac core, and "axi"
> clk for the AXI bus logic.
> 
> To support for more than one clock, we'll need to distinguish between
> the clock by name. Change clock probing to first try to get "core"
> clock before falling back to unnamed clock.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
