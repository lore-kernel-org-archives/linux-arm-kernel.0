From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 27 Oct 2015 10:24:53 +0900
Subject: [PATCH v2 00/14] dmaenigne: edma/ti-crossbar: fixes, new bindings
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151027012452.GB11691@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 10:17:58AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Comments in the memcpy optimization patch extended
> - The crossbar patch has been improved:
>  - debug prints changed
>  - fallback xbar parameters now type specific as the fallback values for DRA7
>    are not valid for AM33xx crossbar.
> - New patch for Kconfig to select the crossbar in case the eDMA is used on OMAP
>   platforms
> 
I am applying this series and Please note that this has ARM patches which i
have not heard any objections so applying :)

-- 
~Vinod
