From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 27 Feb 2018 19:38:26 +0100
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <20180227070415.GB18666@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost> <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
Message-ID: <20180227183826.GA32473@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > Let's restart this discussion and focus on the main roadblock (others
> > > > are minor details which can be sorted out later).
> > > > 
> > > > If it feels like a hack, the key issue seems to me to be the choice of
> > > > the API to present the GPS data to user space. Right?
> > > 
> > > Or even more fundamentally, does this belong in the kernel at all?
> > 
> > Yes, it does.
> 
> But not necessarily in its current form.

Not necessarily, no. OTOH this hack was not too bad IIRC and we
usually do present NMEA to userspace at the moment. We'll need proper
GPS subsystem one day, but I'm afraid that will take some time...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180227/1e96b020/attachment.sig>
