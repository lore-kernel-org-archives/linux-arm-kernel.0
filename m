From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 30 Sep 2015 19:35:21 +0200
Subject: [PATCH 1/2] dma: pxa_dma: fix the no-requestor case
In-Reply-To: <20150930062422.GC21690@vkoul-mobl.iind.intel.com> (Vinod Koul's
 message of "Wed, 30 Sep 2015 11:54:22 +0530")
References: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
 <20150930062422.GC21690@vkoul-mobl.iind.intel.com>
Message-ID: <87fv1verom.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Thu, Sep 10, 2015 at 07:17:45PM +0200, Robert Jarzmik wrote:
>> A very small number of devices don't use the flow control offered by
>> requestor lines. In these specific cases, the pxa dma driver should be
>> aware of that and not try to use a requestor line.
>
> And these fail for me, what were these sent against?
v4.2. My fault, in v4.2-rc1 the patch 0e95fb9ceb82 ("dmaengine: pxa_dma: don't
use config direction parameter") impact this one.

> Please rebase and resend
Of course, I'm on it.

Cheers.

-- 
Robert
