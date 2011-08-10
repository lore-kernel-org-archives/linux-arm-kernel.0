From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2011 18:05:44 +0200
Subject: [PATCH] mach-sa1100: fix PCI build problem
In-Reply-To: <CAKnu2MoBnHDVht0LPR0ip1iZqojh2ab+wx=6mCj-+M2+yOpA3w@mail.gmail.com>
References: <1312539884-10631-1-git-send-email-linus.walleij@linaro.org>
	<CAKnu2MoBnHDVht0LPR0ip1iZqojh2ab+wx=6mCj-+M2+yOpA3w@mail.gmail.com>
Message-ID: <201108101805.45133.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011, Linus Walleij wrote:
> 2011/8/5 Linus Walleij <linus.walleij@linaro.org>:
> 
> > The PCI nanoengine driver in the SA1100 machine probably has not
> > been building for some time. It probably dragged hardware.h
> > in implicitly and now it doesn't anymore. After this an SA1100
> > build selecting all system variants will build successfully.
> 
> Arnd can you pick this single patch for the -rc series, or do you
> prefer pull requests?

I've put this one into the fixes branch and will push it to Linus
when that branch has gained critical mass.

I generally prefer git pull requests, but for single patches,
email is absolutely fine and I won't reject patches I get by
email. However, when you want me to apply a patch or git tree,
please always take me on Cc. When you send something only to the
mailing list, I will assume that it's for either review or that
you are sending it to someone else.

To make it less ambiguous, best put me in the 'To' field and the
mailing list on 'Cc' for stuff you want me to apply, or the other
way round for stuff that you want to have reviewed.

	Arnd
