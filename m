From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 13:12:11 +0000
Subject: [GIT PULL] i.MX clock fixes for v3.8
In-Reply-To: <20130205112558.GA1906@pengutronix.de>
References: <20130205095844.GZ1906@pengutronix.de>
 <20130205110804.GI17786@n2100.arm.linux.org.uk>
 <20130205112558.GA1906@pengutronix.de>
Message-ID: <201302051312.11434.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013, Sascha Hauer wrote:
> >        So think twice - or thrice - before sending me patches or a pull
> >        request for -rc7. You need to have some seriously good reasons for
> >        doing so, and you need to state those reasons very clearly. And I
> >        don't just mean for the pull request in general, I mean for every
> >        single patch in it.
> > ...
> >        In other words, "It fixes a bug" just isn't good enough. The bug needs
> >        to be something that actually matters.
> 
> At least 'ARM: i.MX25: clk: parent per5_clk to AHB clock' is a
> regression that causes nasty oopses. Admittedly, it wasn't introduced in
> the last merge window and the board requiring the fix needs out of tree
> patches.
> 
> I'm fine with these going into v3.9 and waiting for the first stable
> patch to get the fix for the above.

My rules is usually: if it's important enough to have it backported
into a stable kernel, then it's also important enough to get sent
at any time during the bug fix phase.

The patch you  mentioned certainly fits that category. The other one
might as well, but the patch description does not actually say what
the impact of the bug is, so it is hard to tell.

	Arnd
