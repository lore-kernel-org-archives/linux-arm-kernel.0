From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 25 Nov 2013 23:03:36 +0100
Subject: [PATCH 3/4] ARM: mvebu: NETGEAR ReadyNAS 104 .dts file cleanup
In-Reply-To: <20131125194117.GA5413@obsidianresearch.com> (Jason Gunthorpe's
 message of "Mon, 25 Nov 2013 12:41:17 -0700")
References: <cover.1385148929.git.arno@natisbad.org>
 <bd899cfc2b0b3d22a7442d76b3901ca81ca86f11.1385148929.git.arno@natisbad.org>
 <20131122213610.GC30358@obsidianresearch.com>
 <878uwg5b6e.fsf@natisbad.org>
 <20131125194117.GA5413@obsidianresearch.com>
Message-ID: <87vbzgf8av.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:

> On Fri, Nov 22, 2013 at 11:22:33PM +0100, Arnaud Ebalard wrote:
>
>> and also the fact that *in my case* the kernel does its job
>> auto-detecting the PHY, I now also wonder how the kernel can
>> use that info and what I get by adding the compatible string.
>
> I think the main rational was to document what chip the phy is to
> people who don't have the hardware...
>
> You probably shouldn't delay your patch on this issue, document the
> phy chip model in a comment?

Will do that.

> Also, check if it is actually an S varient or not, they have the same
> phy-id.. ;)

On the chip, I have 88E1318-NNB2 (PNN1230_3JW 1209 A0P TW). I will see
if I can find more info.

Cheers,

a+
