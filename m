From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 24 May 2012 12:18:11 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FBBB974.1060107@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120521161131.GC24270@n2100.arm.linux.org.uk>
 <20120521165800.GR24238@titan.lakedaemon.net>
 <201205211940.25488.arnd@arndb.de>
 <alpine.LFD.2.02.1205221023050.13185@xanadu.home>
 <20120522160316.GY24238@titan.lakedaemon.net>
 <4FBBB974.1060107@codethink.co.uk>
Message-ID: <4FBE18F3.7080908@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/12 17:06, Ben Dooks wrote:
> On 22/05/12 17:03, Jason Cooper wrote:

[snip]

> I'm going to say let's leave these alone for the moment. The kernel
> per-version diff is large enough as it is and moving stuff around for
> the sake of it is just going to make it larger and thus draw more
> unwanted attention to arch/arm.

We can re-visit this once we've had a chance to move the items out of
plat-orion which can go under drivers/

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
