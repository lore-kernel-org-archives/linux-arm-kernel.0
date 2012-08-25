From: horms@verge.net.au (Simon Horman)
Date: Sat, 25 Aug 2012 16:13:44 +0900
Subject: [PATCH 0/2] Renesas IPMMU driver for sh7372
In-Reply-To: <1343197742-13630-1-git-send-email-hdk@igel.co.jp>
References: <1343197742-13630-1-git-send-email-hdk@igel.co.jp>
Message-ID: <20120825071344.GI29755@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 03:29:00PM +0900, Hideki EIRAKU wrote:
> This is the Renesas IPMMU driver, IOMMU API implementation and IPMMU
> device support for sh7372 (AP4EVB and Mackerel).
> 
> The IPMMU module supports the MMU function and the PMB function.  The
> MMU function provides address translation by pagetable compatible with
> ARMv6.  The PMB function provides address translation including
> tile-linear translation.  This is implementation of the MMU function.

Hi,

I am wondering if anyone has had a chance to review this short series.
It seems reasonable to me with the minor exception that I would
be happier the second patch to update the relevant defconfigs
to either enable or disable the driver.

I am also curious to know how this driver may be tested.
