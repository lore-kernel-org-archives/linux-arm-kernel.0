From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 20 Jan 2014 18:20:32 +0800
Subject: [PATCH v4] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <20140120084738.GO26823@intel.com>
References: <1389190369-2012-1-git-send-email-21cnbao@gmail.com>
 <20140120074857.GJ26823@intel.com>
 <CAGsJ_4zcwCx0RNMNx8YaDBFtGE=02-B79+WKDGeky80X5agcuw@mail.gmail.com>
 <20140120084738.GO26823@intel.com>
Message-ID: <CAGsJ_4w7=_QZmvewQVBAN1sEsivqvUq1reVMAijKADo6JTLzRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/20 Vinod Koul <vinod.koul@intel.com>:
> On Mon, Jan 20, 2014 at 05:35:07PM +0800, Barry Song wrote:
>> 2014/1/20 Vinod Koul <vinod.koul@intel.com>:
>> > On Wed, Jan 08, 2014 at 10:12:49PM +0800, Barry Song wrote:
>> >> From: Barry Song <Baohua.Song@csr.com>
>> >>
>> >> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
>> >> we add a xlate() to let dma clients be able to find right dma_chan by generic
>> >> "dmas" properties in dts.
>> >>
>> >> Cc: Mark Rutland <mark.rutland@arm.com>
>> >> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> >> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> > Look okay, need an ACk from DT maintainers before I can apply...
>>
>> Vinod, will i send v5 with your ack to
>> devicetree-discuss at lists.ozlabs.org, and CC Grant & Rob?
> Which tree are you tragetting this, if dmaengine then my ack make no sense :)
>
>>
>> Hi Rob, will you Ack this one if you have noticed this thread?
> I dont think Robs email is avlid anymore, I think he moved to Linaro, if I am
> not mistaken.
>
> ~Vinod

ok. i will resend the patch with dts guys.


>> > ~Vinod
>> >> ---
>> >>  -v4: clear dt-binding document according to Mark's feedback
>>
>> -barry

-barry
