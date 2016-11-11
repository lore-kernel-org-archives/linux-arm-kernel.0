From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 11 Nov 2016 23:06:32 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
References: <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd> <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd>
 <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
Message-ID: <20161111220631.GA10983@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Hmm. So userland can read the LED state, and it can get _some_ value
> >back, but it can not know if it is current state or not.
> >
> >I don't think that's a good interface. I see it is from 2008... is
> >someone using it? Maybe it is too late for revert.
> 
> I can imagine it being used in flash LED use case. E.g. one
> could use oneshot trigger to trigger flash strobe, and then
> he could periodically read brightness file to check, for whatever
> reason, whether the flash is strobing.

I'm pretty sure nobody does that for flah strobe.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/e6116c19/attachment.sig>
