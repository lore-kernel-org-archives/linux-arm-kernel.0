From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 06:57:12 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120516050708.GF23254@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205152135.26759.arnd@arndb.de> <20120516050708.GF23254@lunn.ch>
Message-ID: <201205160657.12833.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Andrew Lunn wrote:
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Has this been tested in any way? If it boots on a few different
> boards, i would say yes, lets do it.
> 
> If this is for the end of the merge window, we have about two weeks
> for testing. Seems reasonable.
> 

No testing in any way other than building the four defconfigs, but I've been
rather careful in coming up with a way that would be least invasive. I agree
it needs real testing anyway.

	Arnd
