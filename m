From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Sep 2010 12:40:04 +0100
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <AANLkTikT5Jg5dqfjMrNTxb57BaGmcuAqsqiC9e7_d0TW@mail.gmail.com>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
	<AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
	<20100911113236.GA25922@n2100.arm.linux.org.uk>
	<AANLkTikT5Jg5dqfjMrNTxb57BaGmcuAqsqiC9e7_d0TW@mail.gmail.com>
Message-ID: <20100911114004.GB25922@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 11, 2010 at 01:39:04PM +0200, Linus Walleij wrote:
> 2010/9/11 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > You'll find !! used throughout the kernel sources.
> 
> Aha it's a kernel idiom, OK!!
> 
> I'll just test it on hardware and I'll put it in the patch tracker.
> 
> From: Linus Walleij <linus.walleij@stericsson.com>
> Date: Sat, 11 Sep 2010 13:36:20 +0200
> Subject: [PATCH] MMCI: use _cansleep GPIO functions
> 
> Currently the kernel is screaming about slowpath at me for the
> wp/cd callbacks. Swicth to the _cansleep variants so as to silence
> this.

You may wish to correct that spelling error.
