From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 28 Jun 2015 20:15:29 +0530
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <CAH=tA9F3=oqWi66EpkG-ecWHuVbOua+ceeiQD03WjiA=QdgA-g@mail.gmail.com>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
 <20150622104932.GC19530@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A49A91915@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150627144054.GW19530@localhost>
 <CAH=tA9F3=oqWi66EpkG-ecWHuVbOua+ceeiQD03WjiA=QdgA-g@mail.gmail.com>
Message-ID: <20150628144529.GZ19530@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 27, 2015 at 05:44:38PM +0300, Nicolae Rosia wrote:
> On Sat, Jun 27, 2015 at 5:40 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> [...]
> >> Please let me know if you are not clear.
> > No sorry am not...
> >
> > I asked how the device address in configured. For both MM2S S2MM you are
> > using sg for memory address, where are you getting device adress, are you
> > assuming/hardcoding or getting somehow, if so how?
> As the name says, one end is memory (MM) and the other end is an AXI4
> Stream Bus (S) which has no concept of memory address.
> So yes, it is hardcoded at design time.
So where does the data go at the end of stream bus, who configures that?
Shouldnt all this be at least documented...

-- 
~Vinod
