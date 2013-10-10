From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 11 Oct 2013 00:22:10 +0200
Subject: [RFCv3 0/7] OMAP SSI driver
In-Reply-To: <20131010201914.GC29989@blackmetal.musicnaut.iki.fi>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <20131008172815.GA8313@atomide.com>
 <20131010172128.GF28657@earth.universe>
 <20131010182801.GB29989@blackmetal.musicnaut.iki.fi>
 <20131010200236.GA6603@earth.universe>
 <20131010201914.GC29989@blackmetal.musicnaut.iki.fi>
Message-ID: <20131010222210.GA7938@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 11:19:14PM +0300, Aaro Koskinen wrote:
> On Thu, Oct 10, 2013 at 10:02:36PM +0200, Sebastian Reichel wrote:
> > P.S.: You can get a mainline kernel status matrix for the Nokia
> >       N900 on this page: http://elinux.org/N900
> 
> Thanks for summary,

You're welcome.

> and the above page looks very useful. I wonder would it make sense
> to add also N9/N950 there (some functionality is shared)?

mh maybe. I haven't looked @ N9/N950 so far, since I don't own them.
I would be interested in a N950, but I don't own one and it's almost
impossible to get one :(

Apart from that I'm not sure if it's a good idea to make the table
even more complex. Maybe just add a new page?

> Also TWL4030 DT status could be updated, e.g. watchdog support
> was done already last year with 8899b8d93ec64b7a8e54807a68a958e1206535e2.

Yes. I only recently added the DT column and have not yet checked
all the drivers. Probably it's also a good idea to split this
column into "driver supports DT" and "DT file supports it".

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131011/6e3fd846/attachment.sig>
