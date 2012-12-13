From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 12 Dec 2012 17:16:17 -0800
Subject: [PATCH v4 0/7] enable support for AMBA drivers under x86
In-Reply-To: <CACxGe6v97ZnJpggcSE2HEE0S7wZFrYgFW0Hmok7D9h8ByufqGg@mail.gmail.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <50C92366.8030604@zytor.com>
 <CACxGe6v97ZnJpggcSE2HEE0S7wZFrYgFW0Hmok7D9h8ByufqGg@mail.gmail.com>
Message-ID: <50C92C61.8060104@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 05:10 PM, Grant Likely wrote:
> On Thu, Dec 13, 2012 at 12:37 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> OK, so I'm not 100% sure how to best handle this patchset.  I can carry it
>> in the x86 tree with the appropriate ACKs... which could lead to ugly merge
>> conflicts, or we can ask the respective driver authors to take their bits...
>> but that gives a sequencing problem (the core patchset depends on a bunch of
>> outside trees in order to be tested.)
>>
>> Either way it is a late pull for 3.8 at best... however, the risk seems low
>> so *maybe* that is acceptable.
> 
> I'd put the whole series into a separate branch by itself and any
> subsystems with problematic conflicts can merge it into their trees
> also. I'm fine with putting it in the x86 tree for v3.9. I don't think
> there is any huge rush on it.
> 

That was pretty much my preferred option.  I'll put it into tip:x86/amba.

	-hpa
