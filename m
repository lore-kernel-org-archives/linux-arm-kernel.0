From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 11 Aug 2018 15:41:35 +0200
Subject: [PATCH 2/2] dt-bindings: clock: Add bindings for the Clocking
 Wizard IP
In-Reply-To: <CAKfKVtGHwafCtPo2MR-dw-61UYH3A4H3bRZ9ipGuGx5bLBNp3Q@mail.gmail.com>
References: <20180801081950.10497-1-boris.brezillon@bootlin.com>
 <20180801081950.10497-2-boris.brezillon@bootlin.com>
 <CAKfKVtGHwafCtPo2MR-dw-61UYH3A4H3bRZ9ipGuGx5bLBNp3Q@mail.gmail.com>
Message-ID: <20180811154135.4e998d6b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

On Sat, 11 Aug 2018 16:18:54 +0530
Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com> wrote:

> Hi  Boris,
> 
> 
> On Wed, Aug 1, 2018 at 1:49 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Document Xilinx Clocking Wizard bindings.
> >  
> 
> Thanks for the patches.
> Are you planning to post another version patching the staging?

Yes, but that won't happen before a few weeks, so, if you can't wait,
feel free to port my changes to the existing driver. Would be good to
also address the aspect that initially prevented this driver from being
merged in the clk subsystem, so that we can finally move it there.

Regards,

Boris
