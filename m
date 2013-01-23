From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Jan 2013 16:19:18 +0530
Subject: [PATCH v5 00/14] DMA Engine support for AM33XX
In-Reply-To: <20130123022133.GA5727@opensource.wolfsonmicro.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <50FEB6B2.5020303@ti.com> <20130123022133.GA5727@opensource.wolfsonmicro.com>
Message-ID: <50FFC02E.5090703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 1/23/2013 7:51 AM, Mark Brown wrote:
> On Tue, Jan 22, 2013 at 09:26:34PM +0530, Sekhar Nori wrote:
>> On 1/16/2013 2:02 AM, Matt Porter wrote:
> 
>>> This series adds DMA Engine support for AM33xx, which uses
>>> an EDMA DMAC. The EDMA DMAC has been previously supported by only
>>> a private API implementation (much like the situation with OMAP
>>> DMA) found on the DaVinci family of SoCs.
> 
>> Will you take this series through the OMAP tree? Only 1/14 touches
>> mach-davinci and I am mostly okay with it except some changes I just
>> requested Matt to make in another thread.
> 
> Is this series somewhere near actually getting merged then? It seemed
> like there was lots of stuff going on.

I don't think there is a lot of churn on this now. 5 of the patches have
already been acked by Tony. I had a look at the first two patches (from
davinci perspective) and they mostly look good to me.

That said, I was not intending to suggest the entire series was ready
for merging. Since the series touches multiple areas of the kernel, I
wanted to make sure we have one person shepherding the series towards
mainline.

Patch 1/14 has some changes in sound/ can you please take a look and ack
them?

Thanks,
Sekhar
