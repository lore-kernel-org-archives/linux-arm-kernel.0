From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 1 Oct 2015 07:45:21 +0530
Subject: [PATCH v2 1/2] dma: pxa_dma: fix the no-requestor case
In-Reply-To: <1443634935-28989-1-git-send-email-robert.jarzmik@free.fr>
References: <1443634935-28989-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20151001021521.GF11757@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 07:42:14PM +0200, Robert Jarzmik wrote:
> A very small number of devices don't use the flow control offered by
> requestor lines. In these specific cases, the pxa dma driver should be
> aware of that and not try to use a requestor line.

Applied both now

Btw what happened to subsytem name here!!

-- 
~Vinod
