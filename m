From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Mar 2014 10:21:05 +0530
Subject: [PATCH v4] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <CAGsJ_4zMYGTS4CyCsTAH_5PMK3v4Pr+e88YjXL=d3A=EjPf9rQ@mail.gmail.com>
References: <1389190369-2012-1-git-send-email-21cnbao@gmail.com>
 <20140120074857.GJ26823@intel.com>
 <CAGsJ_4zcwCx0RNMNx8YaDBFtGE=02-B79+WKDGeky80X5agcuw@mail.gmail.com>
 <CAGsJ_4zMYGTS4CyCsTAH_5PMK3v4Pr+e88YjXL=d3A=EjPf9rQ@mail.gmail.com>
Message-ID: <20140317045105.GB1976@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 10:49:18AM +0800, Barry Song wrote:
> 2014-01-20 17:35 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> > 2014/1/20 Vinod Koul <vinod.koul@intel.com>:
> >> On Wed, Jan 08, 2014 at 10:12:49PM +0800, Barry Song wrote:
> >>> From: Barry Song <Baohua.Song@csr.com>
> >>>
> >>> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
> >>> we add a xlate() to let dma clients be able to find right dma_chan by generic
> >>> "dmas" properties in dts.
> >>>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> >> Look okay, need an ACk from DT maintainers before I can apply...
> 
> Hi Vinod,
> v5 is sent to devicetree list and there is no object.
> http://www.spinics.net/lists/devicetree/msg19677.html
> this patch is using general dt-binding for dma completely same with
> other dma drivers, there is no special binding here.
> so i think there is no reason to wait for merging since now updates
> for its clients e.g. SPI, UART have been in 3.14-rc.
I still need the ack for DT folks... Seems still missing :(

-- 
~Vinod
