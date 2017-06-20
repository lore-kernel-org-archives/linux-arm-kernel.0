From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 20 Jun 2017 10:29:33 +0200
Subject: Shawn Guo: your attetion is needed here Re: [PATCH v8 00/34] i.MX
 Media Driver
In-Reply-To: <43887f25-bb73-9020-0909-d275c319aaad@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <e7e4669c-2963-b9e1-edd7-02731a6e0f9c@xs4all.nl>
 <c0b69c93-b9cd-25e8-ea36-fc0600efdb69@gmail.com>
 <e4f152de-6e75-7654-178e-e6dcf9ad12f3@xs4all.nl>
 <43887f25-bb73-9020-0909-d275c319aaad@mentor.com>
Message-ID: <20170620082933.GA31799@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> But as Pavel pointed out, in fact we are missing many
> >> Acks still, for all of the dts source changes (patches
> >> 4-14), as well as really everything else (imx-media staging
> >> driver patches).
> > 
> > No Acks needed for the staging part. It's staging, so not held
> > to the same standards as non-staging parts. That doesn't mean
> > Acks aren't welcome, of course.
> 
> Acks are wanted for particular i.MX DTS changes including device
> tree binding descriptions.
> 
> Shawn, please bless the series.

Hmm. I changed the subject to grab Shawn's attetion.

But his acks should not be needed for forward progress. Yes, it would
be good, but he does not react -- so just reorder the series so that
dts changes come last, then apply the parts you can apply: driver can
go in.

And actually... if maintainer does not respond at all, there are ways
to deal with that, too...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/f6680805/attachment.sig>
