From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Sat, 2 Apr 2011 08:40:00 +0000
Subject: [PATCH 1/1] net/fec: do not pass NULL dev to DMA API
In-Reply-To: <20110402.013541.02274640.davem@davemloft.net>
References: <20110402.005714.258110130.davem@davemloft.net>
	<20110402083131.GB26533@S2100-06.ap.freescale.net>
	<AANLkTi=FMsH7Px2m9WkRVyHfGZ9MLvgp-XPHu3Amsu7+@mail.gmail.com>
	<20110402.013541.02274640.davem@davemloft.net>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77214DD02@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: David Miller [mailto:davem at davemloft.net]
> Sent: Saturday, April 02, 2011 4:36 PM
> To: liu.h.jason at gmail.com
> Cc: Guo Shawn-R65073; netdev at vger.kernel.org; Dong Aisheng-B29396; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] net/fec: do not pass NULL dev to DMA API
> 
> From: Jason Liu <liu.h.jason@gmail.com>
> Date: Sat, 2 Apr 2011 16:35:19 +0800
> 
> > 2011/4/2 Shawn Guo <shawn.guo@freescale.com>:
> >> Hi David,
> >>
> >> On Sat, Apr 02, 2011 at 12:57:14AM -0700, David Miller wrote:
> >>>
> >>> First, your patches never make it to the mailing list because the
> >>> list server rejects your postings, due to the fact that there are
> >>> syntax errors in your email headers:
> >>>
> >>> Illegal-Object: ? ? ? Syntax error in From: address found on
> vger.kernel.org:
> >>> ? ? ? From: ? Aisheng.Dong<b29396@freescale.com>
> >>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ^-missing end of mailbox
> >>>
> >> Yes, we were aware of that the mail did not get distributed by vger
> >> list. ?But we do not know why. ?Thanks for telling.
> >>
> >> I'm not quite sure about the "^" indication. ?Is it telling that
> >> there should be a space between display name and mail address?
> >
> > We should not use A.B <>, instead should use A B <>.
> 
> Yes, this is also true.
> 
> Characters such as "." must not appear in email headers in this context
> unless protected by double quotes.
Thanks a lot David.
This issue has bothered me a lot and finally the root cause is found.

For the patch I just found it was already fixed in your 2.6.x -next tree.
Thanks for the info.

Regards
Aisheng
