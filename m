From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 Dec 2016 22:13:41 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
Message-ID: <20161207164341.GX6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 01:14:20PM +0000, M?ns Rullg?rd wrote:
> 
> That's not going to work very well.  Device drivers typically request
> dma channels in their probe functions or when the device is opened.
> This means that reserving one of the few channels there will inevitably
> make some other device fail to operate.

No that doesnt make sense at all, you should get a channel only when you
want to use it and not in probe!

-- 
~Vinod
