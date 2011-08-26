From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2011 17:53:02 +0200
Subject: [GIT PULL] orion5x and footbridge compile fixes for 3.1
In-Reply-To: <4E565AC4.7060504@gmail.com>
References: <4E565AC4.7060504@gmail.com>
Message-ID: <201108261753.03086.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011, Rob Herring wrote:
> Please pull for 3.1-rc. Footbridge and orion5x builds are currently
> broken in 3.1 mainly due to my changes in this commit:
> 
> commit cc22b4c18540e5e8bf55c7d124044f9317527d3c
> Author: Rob Herring <rob.herring@calxeda.com>
> Date:   Tue Jun 28 21:22:40 2011 -0500
> 
>     ARM: set vga memory base at run-time
> 
> 
> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 

Pulled, thanks!

BTW, are you planning to get your own git tree in the future or do you keep using
Jon's git.jdl.com server?

It should be no problem for you to get hosting on git.kernel.org, there is
a FAQ somewhere. With the current situation, it's now clear from the changelog
why I am pulling patches from Jon's server with your Signed-off-by.

	Arnd
