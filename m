From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Sep 2010 12:32:36 +0100
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
	<AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
Message-ID: <20100911113236.GA25922@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 11, 2010 at 01:22:04PM +0200, Linus Walleij wrote:
> I'll slam in some intermediate bool or something so it's super
> clear what's happening, OK?

No - once you've learnt that !! turns an int into a bool, there's
nothing more that needs to be done.

You'll find !! used throughout the kernel sources.
