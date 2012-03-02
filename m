From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 2 Mar 2012 11:25:20 +0100
Subject: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card
 detect
In-Reply-To: <20120301185535.29210.71546.stgit@kaulin.local>
References: <20120301185044.29210.44521.stgit@kaulin.local>
 <20120301185535.29210.71546.stgit@kaulin.local>
Message-ID: <20120302102520.GQ9008@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Mar 01, 2012 at 10:55:35AM -0800, Tony Lindgren wrote:
> There's no need to use callbacks for this, we can
> do it directly between MMC driver and twl6030.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
