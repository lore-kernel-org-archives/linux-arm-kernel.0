From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jan 2017 16:27:11 -0800
Subject: [GIT PULL] ARM: aspeed: devicetree for 4.11
In-Reply-To: <CACPK8XffqYCRipx+KzxyH0z-5=t53ezPjRv+MxOj7-tj2kbG2A@mail.gmail.com>
References: <CACPK8XffqYCRipx+KzxyH0z-5=t53ezPjRv+MxOj7-tj2kbG2A@mail.gmail.com>
Message-ID: <20170119002711.GJ23725@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 09:50:02AM +1100, Joel Stanley wrote:
> Hello Arnd and Olof,
> 
> Please pull the Aspeed devicetree ...tree for 4.11.
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-4.11-devicetree
> 
> for you to fetch changes up to 8f9bafbb92c0308cf8d33536803c822e14bed4d7:
> 
>   ARM: dts: aspeed: Add Romulus BMC platform (2017-01-10 21:55:46 +1100)
> 
> ----------------------------------------------------------------
> Aspeed devicetree updates for 4.11
> 
> This introduces the first OpenPower Power9 BMC system, Romulus. Romulus is
> based on the ast2500 SoC from Aspeed.
> 
> These commits also add newly upstreamed drivers to the Palmetto BMC and ast2500
> eval board. We now have working network, ipmi bt, gpio and pinmux on
> all platforms.
> 
>   ARM: dts: aspeed: Add Romulus BMC platform
>   ARM: dts: aspeed: Add ftgmac100 to g4 and g5 platforms
>   ARM: dts: aspeed: Correct palmetto device tree
>   ARM: dts: aspeed: Reserve framebuffer memory
>   ARM: dts: aspeed-g5: Add gpio controller to devicetree
>   ARM: dts: aspeed-g5: Add syscon and pin controller nodes
>   ARM: dts: aspeed-g5: Add LPC Controller node
>   ARM: dts: aspeed-g5: Add SoC Display Controller node
>   ARM: dts: aspeed-g4: Add gpio controller to devicetree
>   ARM: dts: aspeed-g4: Add syscon and pin controller nodes

Hi,

Merged, but for the future there's no need for you to list the patches in the
tag message, git inserts a list when we merge (--log), and git request-pull
already provides the shortlog.


(512MB RAM on a BMC? That's just insane :).



-Olof
