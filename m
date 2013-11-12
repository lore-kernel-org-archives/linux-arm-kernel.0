From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Nov 2013 09:20:35 +0530
Subject: [PATCH][RESEND 3/8] dma: mmp_tdma: use gen_pool_dma_alloc() to
 allocate descriptor
In-Reply-To: <b7d5dce9fcc118a60261824196c820de6fb434a2.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
 <b7d5dce9fcc118a60261824196c820de6fb434a2.1383306365.git.b42378@freescale.com>
Message-ID: <20131112035035.GD8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 07:48:16PM +0800, Nicolin Chen wrote:
> Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
