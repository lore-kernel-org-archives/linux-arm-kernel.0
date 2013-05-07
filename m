From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 May 2013 19:19:53 +0200
Subject: [GIT PULL] ARM: Third batch of arm-soc changes for 3.10
In-Reply-To: <CA+55aFwMXmJ9V+3o62ELm-0NT1DaUCTvidmAhJSXzQcTMfJygA@mail.gmail.com>
References: <1367942534-2934003-1-git-send-email-arnd@arndb.de>
 <CA+55aFwMXmJ9V+3o62ELm-0NT1DaUCTvidmAhJSXzQcTMfJygA@mail.gmail.com>
Message-ID: <201305071919.53353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 May 2013, Linus Torvalds wrote:
> On Tue, May 7, 2013 at 9:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I used a new script to create the pull requests this time, hope
> > I got it right now.
> 
> So you seem to have blasted this series out with that automated
> script, so they all got sent basically at the same timestamp, and they
> are in the wrong order in my mailbox because email isn't that ordered.

Yep, I'm very sorry about that. The old script I used had been a bit
fragile so I stopped using it for the last few merge windows
but tried something simpler this time. I had the sequence numbers
in the script but forgot to actually write them out in the subject.

> Of course, when there aren't any dependencies between pull requests,
> and the ordering doesn't matter, this isn't an issue. And *most* of
> the time you either have sent out emails by hand (and there's been
> that human delay and they arrived in the right order) or I've just
> been lucky.

I think it's the first time I made /this/ mistake, they were always
numbered in the past, and usually also had distinct time stamps.
 
> Quite frankly, I'm not going to bother guessing after the first one I
> took was clearly not the right one and gave the wrong diffstat etc, so
> they are all thrown down the toilet.
> 
> Nothing pulled.

Yes, of course. It was an obvious mistake and I would have rejected
it the same way coming from my downstream maintainers. Sorry about
bothering you with this and your lenghty reply. I hope you don't
mind the contents, and I'll follow up with the same pull requests
again, using sequence numbers.

	Arnd
