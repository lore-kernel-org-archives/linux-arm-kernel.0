From: eric@anholt.net (Eric Anholt)
Date: Tue, 07 Jun 2016 14:56:10 -0700
Subject: Updating Raspberry Pi trees pulled for -next
In-Reply-To: <20160607093928.11a82881@canb.auug.org.au>
References: <87wpm22co5.fsf@eliezer.anholt.net>
 <20160607093928.11a82881@canb.auug.org.au>
Message-ID: <8737oo64ud.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Eric,
>
> On Mon, 06 Jun 2016 15:08:26 -0700 Eric Anholt <eric@anholt.net> wrote:
>>
>> I was going to bother you to add a bunch more trees to pull into -next
>> now that I'll be merging arm64 changes for the Raspberry Pi 3, but
>> instead I've decided to start using the maint-scripts to make generating
>> a single for-next branch trivial.
>
> Thanks for that.
>
>> So, could you replace all of my -next branches you're pulling with:
>> 
>> git://github.com/anholt/linux.git#for-next
>
> Done.

In next-20160607 I see drm-vc4-next merged separately, which I also
included in for-next.  I think it would be best to drop that one, too.

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/3182dede/attachment.sig>
