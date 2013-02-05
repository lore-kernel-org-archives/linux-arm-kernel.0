From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Feb 2013 11:08:04 +0000
Subject: [GIT PULL] i.MX clock fixes for v3.8
In-Reply-To: <20130205095844.GZ1906@pengutronix.de>
References: <20130205095844.GZ1906@pengutronix.de>
Message-ID: <20130205110804.GI17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 10:58:44AM +0100, Sascha Hauer wrote:
> Hi Arnd, Olof,
> 
> Please pull these two fixes for v3.8

If you haven't heard, Linus wants each and every patch going into v3.8
meeting this criteria:

       fix major security issues, big user-reported regressions, or nasty
       oopses.

and individually justified:

       So think twice - or thrice - before sending me patches or a pull
       request for -rc7. You need to have some seriously good reasons for
       doing so, and you need to state those reasons very clearly. And I
       don't just mean for the pull request in general, I mean for every
       single patch in it.
...
       In other words, "It fixes a bug" just isn't good enough. The bug needs
       to be something that actually matters.
