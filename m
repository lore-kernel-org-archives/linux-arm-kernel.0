From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Jul 2012 12:35:31 +0200
Subject: [RFC PATCHv2 0/2]arm: socfpga: Add initial support for Altera's
 SOCFPGA HW
In-Reply-To: <1342543585.13530.3.camel@dinh-ubuntu>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <20120716213752.GA28680@elf.ucw.cz>
 <201207171543.42889.arnd@arndb.de>
 <1342543585.13530.3.camel@dinh-ubuntu>
Message-ID: <20120718103531.GA12078@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Arnd, do you think this is good enough to go to the next tree? It
> > > is new architecture, it should not break anything, I believe we
> > > addressed all the issues raised in the review, and noone is reporting
> > > new ones.
> > > 
> > > Plus, if we could make initial support into 3.6, that would be very
> > > nice :-).
> > 
> > I think we can make it for v3.6, but it's very late for that and I
> > haven't looked at it enough in the past. I have a few small
> > comments, so if you can address them quickly we can take it.
> 
> Hi Arnd. Thanks, please fire away your comments.

Arnd wanted quick reactions, so I took liberty of creating
PATCHv4. (You are marked in From: so you'll still get the credit
:-). I hope that is not a big problem.

I'm now pushing for-altera-0718 with the PATCHv4 (+ .config file).

Now, I guess at this point it would be useful to make our repository
public? 

(Oh, and cross the fingers for us so that it finally gets merged :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
