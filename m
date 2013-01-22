From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Jan 2013 17:12:41 +0000
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer
 for Armada 370/XP
In-Reply-To: <201301212044.41865.arnd@arndb.de>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301211831.45947.arnd@arndb.de>
 <CAKGA1b=9WQNwHOz=k13XVc=MyZT1UrcaYj8muF2A5B4eJA5+MA@mail.gmail.com>
 <201301212044.41865.arnd@arndb.de>
Message-ID: <20130122171241.GL23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 08:44:41PM +0000, Arnd Bergmann wrote:
> Documentation is generally considered a good thing, but few people
> can be bothered to write it, and few of the other people that should
> read it actually do.

Actually _that_ is just one of the problems with documentation.  The
whole thing is full of problems:

1. People don't write documentation.

2. People don't bother to update correct documentation when the code
   changes in a way that the documentation should be updated for.

3. People don't bother to read documentation which is provided.

(2) is about as bad as it gets - because the small percentage of people
who do read the documentation rather than the code now are lead down
paths which are no longer true.

And (2) educates people to behave like (3).  And (3) educates people to
behave like (1) - why should they bother if they're just going to have
to waste time in an email explaining it time and time again (even when
documentation does exist.)
