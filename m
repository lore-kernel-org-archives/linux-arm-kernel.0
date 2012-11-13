From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 13 Nov 2012 22:31:21 +0100
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <50A28920.7040805@broadcom.com>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
 <201211121500.57638.arnd@arndb.de> <20121112160404.GA22739@glitch>
 <201211121705.29191.arnd@arndb.de> <50A12EA4.90001@wwwdotorg.org>
 <50A28920.7040805@broadcom.com>
Message-ID: <20121113213121.GA14229@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 09:53:36AM -0800, Christian Daudt wrote:
> On 12-11-12 09:15 AM, Stephen Warren wrote:
...
> >I don't really have too strong of a preference. If the eventual intent
> >is for the directory to host all ARM Broadcom SoCs, then mach-bcm seems
> >reasonable.
> >
> Ok, sounds like sticking to mach-bcm has sufficient acks. What I was
> thinking of doing is, once mach-bcm had been introduced, to propose
> to pull in the 476x and 2835 into also, to do some consolidation.
> And have the separate files can keep separate owners - we'd just
> have Kconfig + Makefile shared most likely.

ok also for me

>  Or not. Ultimately I don't mind keeping 2835 and 476x as separate
> mach- either. Those are v6 SoCs, and at this point I have no plans
> on working on mobile v6 SoCs, only v7 onwards. So we can also say
> that mach-bcm is for v7+ SoCs and v6 SoCs keep their existing mach-
> dirs for now.

bcm476x is a non-existent directory yet so I'll be happy to switch to
mach-bcm at the next round (*).

thanks,
Domenico

(*) I'm a bit late with it because I've been distracted by a crazy way
to track kernel regressions I'm hacking on.  it's an experiment to test
a few ideas: http://filibusta.crema.unimi.it/~cavok/kbts/. early comments
are very welcome.
