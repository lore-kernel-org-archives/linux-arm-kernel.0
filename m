From: neil@brown.name (NeilBrown)
Date: Tue, 03 Apr 2018 08:39:55 +1000
Subject: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <20180402114103.GA29354@demeter.lkamp.de>
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
 <87vada1owt.fsf@notabene.neil.brown.name>
 <1522638255.18424.44.camel@mtkswgap22>
 <87po3i1dhu.fsf@notabene.neil.brown.name>
 <20180402114103.GA29354@demeter.lkamp.de>
Message-ID: <87efjx1bd0.fsf@notabene.neil.brown.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02 2018, Christian L?tke-Stetzkamp wrote:

> On Mon, Apr 02, 2018 at 01:41:33PM +1000, NeilBrown wrote:
>> On Mon, Apr 02 2018, Sean Wang wrote:
>> > Hi, Neil
>> >
>> > Forgive me I cannot find the cover letter in the original series in my
>> > mailbox to make a reply, so I rudely made here just letting you know
>> > something good to the growth of mt7621 support in upstream.
>> >
>> > If so, it would become a bit easier for me that maybe I could give a
>> > hand for migrating these staging driver for mt7621 to mainline. I
>> > thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
>> > current mainline code.
>> 
>> I agree that it is quite likely that several of these drivers could and
>> should reuse current mainline code.  I would love to have some help
>> sorting this out.  I won't have much time myself to dig into it for
>> several weeks, but I'll make time to review and test any code that is
>> contributed.
>> 
>> Thanks,
>> NeilBrown
>
> Hi,
>
> I have started a patch series for the mmc driver that is currently in
> staging, that makes some of the first cleanups (whitespace, indent,..)
> and also starts to clean up the code, to make the similarities and
> differences to the current mainline code clearer. The series is far
> from being complete, but I think I'm going to send it out today, so
> you can look and comment.
>
> I would suggest that we continue cleaning the code that is currently
> in staging to remove the dead parts and make the diff to the mainline
> code obvious. Do you agree with that proposal or do you suggest a
> different plan?

I think this is an excellent plan - thanks for doing it.
I'll hopefully look over your patches today and send any comments.

Thanks,
NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/4a26d57f/attachment.sig>
