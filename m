From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 5 Dec 2015 14:17:00 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix bad behavior in interleaved mode
In-Reply-To: <1449072616-22377-1-git-send-email-ludovic.desroches@atmel.com>
References: <1449072616-22377-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151205084700.GX1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 05:10:16PM +0100, Ludovic Desroches wrote:
> From: Sylvain ETIENNE <Sylvain.ETIENNE@ingenico.com>
> 
> When performing interleaved transfers with numf > 1, an extra line is
> copied. The mbr.bc field is incremented once too often. The length of
> the block is (BLEN+1) microblocks.

Applied, thanks

-- 
~Vinod
