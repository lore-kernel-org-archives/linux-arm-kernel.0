From: nicolae.rosia@gmail.com (Nicolae Rosia)
Date: Sat, 27 Jun 2015 17:44:38 +0300
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine driver
 support
In-Reply-To: <20150627144054.GW19530@localhost>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
 <20150622104932.GC19530@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A49A91915@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150627144054.GW19530@localhost>
Message-ID: <CAH=tA9F3=oqWi66EpkG-ecWHuVbOua+ceeiQD03WjiA=QdgA-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 27, 2015 at 5:40 PM, Vinod Koul <vinod.koul@intel.com> wrote:
[...]
>> Please let me know if you are not clear.
> No sorry am not...
>
> I asked how the device address in configured. For both MM2S S2MM you are
> using sg for memory address, where are you getting device adress, are you
> assuming/hardcoding or getting somehow, if so how?
As the name says, one end is memory (MM) and the other end is an AXI4
Stream Bus (S) which has no concept of memory address.
So yes, it is hardcoded at design time.
