From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 20 Jan 2014 18:30:52 +0800
Subject: [PATCH v4] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <20140120074857.GJ26823@intel.com>
References: <1389190369-2012-1-git-send-email-21cnbao@gmail.com>
 <20140120074857.GJ26823@intel.com>
Message-ID: <CAGsJ_4zfcJ2EddrwV2OTcVc7MV71OpY3ACNu=JQT4Nwd6ajecg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/20 Vinod Koul <vinod.koul@intel.com>:
> On Wed, Jan 08, 2014 at 10:12:49PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
>> we add a xlate() to let dma clients be able to find right dma_chan by generic
>> "dmas" properties in dts.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Look okay, need an ACk from DT maintainers before I can apply...


sorry. i just realized Mark has followed this thread and given
comments from the beginning.

Hi Mark,
will you ack this?

>
> --
> ~Vinod
>> ---
>>  -v4: clear dt-binding document according to Mark's feedback
>>

-barry
