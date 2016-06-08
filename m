From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Jun 2016 09:03:01 +0530
Subject: [PATCH] dmaengine: sirf: fix un-exported struct warnings
In-Reply-To: <1465314888-31107-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465314888-31107-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160608033301.GP16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 04:54:48PM +0100, Ben Dooks wrote:
> The sirfsoc_dmadata structs are not used outside the driver, so
> remove build warnings by making them static. Fixes:

Applied, thanks

-- 
~Vinod
