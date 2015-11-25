From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 19:29:24 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151125191600.GM11384@lunn.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
 <20151125183728.GO8644@n2100.arm.linux.org.uk>
 <20151125191600.GM11384@lunn.ch>
Message-ID: <20151125192924.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 08:16:00PM +0100, Andrew Lunn wrote:
> > It feels today like I'm the only one working on improving Dove support,
> > and so it's going to take a _long_ time to move things forward - it's
> > likely to take years.  I have many demands on my time and I have to
> > divide it up between the various aspects.
> 
> Hi Russell
> 
> The problem from our side is the apparent lack of progress. We get so
> very few patches we wounder why we should keep it around. If there was
> even a steady trick of patches, we would feel better about keeping it.

You may think there's lack of progress, but I can tell you that there's
lots of progress on etnaviv right now.  Since 1st November, I've
authored 100 MESA patches, 81 of those merged into Christians repository.
I've also been sorting out issues with the kernel side driver, which
now supports cross-GPU synchronisation, necessary for iMX6, and a
necessary step towards getting the kernel driver merged into mainline.

As I already explained, there is only one of me.  I can only do so much,
and I tend to focus on one part of the broad problem to the exclusion of
other parts - I find chopping and changing all the time to be a much
less efficient way of working.

Others may be able to do a little bit here, a little bit there, but I'm
not like that, sorry.

I won't be able to even start thinking about looking at this stuff until
next week - Arnd wants me to look at some patches he's sent out today,
which I might be able to do tomorrow afternoon at the very earliest,
and I'm probably not around on Friday.

See - I'm only one person, I don't have time to be able to progress
lots of non-paying work at a fast rate.

You'll have to wait, just like I've had to wait to get my own patches
for other stuff in, just like I have to wait for progress in other
projects.  Sorry, but waiting and patience is all part of open source
development, especially when it relies upon volunteer effort.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
