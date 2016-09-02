From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 18:17:05 +0200
Subject: [GIT PULL] delete the RealView boardfiles
In-Reply-To: <CACRpkdar=aL6qXrmpmpYJH8NVN4JkN=DfZR3ShmJucNGU4owmg@mail.gmail.com>
References: <CACRpkdar=aL6qXrmpmpYJH8NVN4JkN=DfZR3ShmJucNGU4owmg@mail.gmail.com>
Message-ID: <9569800.VdlYKZDdVM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 15, 2016 9:01:49 PM CEST Linus Walleij wrote:
> this deletes the RealView boardfiles, good riddance. All is
> device tree now. 3788 deleted lines.
> 
> The missing piece was the CLCD patches that got merged
> by the fbdev maintainer last week.
> 
> I touch oneliners in irqchips and MTD in the process but I
> seriously doubt that they mind.
> 
> Please pull this in for cleanups so we can get it rotating
> in linux-next. (The kautobuild seems happy.)
> 

Pulled into next/cleanup, thanks!

	Arnd
