From: djbw@fb.com (Dan Williams)
Date: Mon, 19 Aug 2013 01:33:26 -0700
Subject: [PATCHv2 0/2] dma: mv_xor: big endian support
In-Reply-To: <20130819042223.GQ32147@intel.com>
References: <1375112534-748-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130815180044.224b14ea@skate> <20130819042223.GQ32147@intel.com>
Message-ID: <CAA9_cmdU4ePytnwMYWpN5a=U4UhHqYKR9qD3rzyoLrO-=ng7zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 18, 2013 at 9:22 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Aug 15, 2013 at 06:00:44PM +0200, Thomas Petazzoni wrote:
>> Vinod, Dan,
>>
>> I've sent the below two patches about three weeks ago, and they haven't
>> received any comments. They are relatively simple, so would it be
>> possible to queue them for 3.12 ?
>>
>> Jason, Andrew, Gregory, as the Marvell EBU maintainers, it would be
>> great if you could give your Acked-by and/or Tested-by on those patches.
>>
>> Thanks!
>>
>> Thomas
>>
>> On Mon, 29 Jul 2013 17:42:12 +0200, Thomas Petazzoni wrote:
>> > Vinod, Dan,
>> >
>> > This small set of patches adds support for big endian operation in the
>> > DMA mv_xor driver. It has been tested in both little-endian and
>> > big-endian modes on the Armada XP GP board.
>> >
>> > If possible, I'd like those to be merged for 3.12.
> These look fine to me.
>
> Dan let me know if you okay with me to carry these

I'm dusting off the tree for a few other patches.  I'll apply them.

--
Dan
