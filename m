From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Dec 2015 20:22:40 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <4984219.tZoFdLBDNB@wuerfel>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <3059482.yN34NFeWWY@wuerfel>
 <20151202192825.GF8644@n2100.arm.linux.org.uk>
 <4984219.tZoFdLBDNB@wuerfel>
Message-ID: <20151202202240.GH8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 08:51:04PM +0100, Arnd Bergmann wrote:
> I'm mostly interested in it because it's the only ARMv7 platform that is
> left after my other patches, and I just want to be done with it after
> spending 5 years on it ;-)

My understanding is that the long term goal is to delete mach-dove once
everyone has settled down into the mvebu DT world.

Right now we have mvebu which covers Dove using DT.  We have mach-dove
which is legacy non-DT Dove.

It seems to me to be completely crazy to want to bring legacy code, which
is ultimately destined to be deleted, into multiplatform.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
