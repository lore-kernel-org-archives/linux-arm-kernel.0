From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Oct 2015 20:01:24 +0530
Subject: [PATCH v5 00/24] dmaengine/ARM: Merge the edma drivers into one
In-Reply-To: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151014143124.GU27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 02:42:42PM +0300, Peter Ujfalusi wrote:
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
> 
> This change will also help us to do bigger changes in the eDMA driver since,
> since now we have only one driver to work with.

I have applied this now. I got a conlfict on 3rd one while applying and also
I got conflict while merging to next

Pls verify all is well!

-- 
~Vinod
