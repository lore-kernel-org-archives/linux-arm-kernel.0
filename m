From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 30 Sep 2015 11:54:22 +0530
Subject: [PATCH 1/2] dma: pxa_dma: fix the no-requestor case
In-Reply-To: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
References: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150930062422.GC21690@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 07:17:45PM +0200, Robert Jarzmik wrote:
> A very small number of devices don't use the flow control offered by
> requestor lines. In these specific cases, the pxa dma driver should be
> aware of that and not try to use a requestor line.

And these fail for me, what were these sent against?
Please rebase and resend

-- 
~Vinod
