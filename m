From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Oct 2015 15:57:55 +0530
Subject: [PATCH v4 00/25] dmaengine/ARM: Merge the edma drivers into one
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151014102755.GL27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 01:01:47PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Cover letter:
> 
> with this series the edma two driver setup will be changed to have only one
> driver to support eDMA3. The legacy edma interface will be removed and eDMA can
> only be used via dmaengine API from this point on.
> In order to do the merge the following improvements has been done:
> - One driver instance per eDMA:
>  - Any number of eDMA instances are supported (both legacy and DT boot)
> - Not relying on global variables, arrays, etc
> - Code simplification and optimizations in several places

One question though, after this move and merge are we still left with edma
in arm/ ?

-- 
~Vinod
