From: davem@davemloft.net (David Miller)
Date: Thu, 09 Jul 2015 01:00:45 -0700 (PDT)
Subject: [RFC Patch V1 07/12] sparc, PCI: Use helper functions to
 access fields in struct msi_desc
In-Reply-To: <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20150709.010045.1327001449508270216.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Thu,  9 Jul 2015 16:00:42 +0800

> Use helper functions to access fields in struct msi_desc, so we could
> easily refine struct msi_desc later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
