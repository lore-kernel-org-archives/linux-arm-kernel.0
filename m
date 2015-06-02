From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 2 Jun 2015 19:05:38 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix "incorrect type in
 assignement" warnings
In-Reply-To: <1433235813-3225-1-git-send-email-rsahu@apm.com>
References: <1433235813-3225-1-git-send-email-rsahu@apm.com>
Message-ID: <20150602133538.GZ3140@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 02:33:33PM +0530, Rameshwar Prasad Sahu wrote:
> This patch fixes sparse warnings like incorrect type in assignment
> (different base types), cast to restricted __le64.
> 
I am appliying this but ideally you should have split thsi into seprate
patches for each fix

-- 
~Vinod
