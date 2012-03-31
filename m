From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 31 Mar 2012 14:27:22 -0400
Subject: Support for Iomega iConnect
In-Reply-To: <20120330232419.GF7274@titan.lakedaemon.net>
References: <201203302330.49834.linux@baker-net.org.uk>
 <20120330232419.GF7274@titan.lakedaemon.net>
Message-ID: <20120331182722.GB817@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 07:24:19PM -0400, Jason Cooper wrote:
> You can also look at the history in this branch to see how support for
> dreamplug (also kirkwood SoC) was added.  Converting drivers to
> devicetree is still a work in progress, so, just match what dreamplug is
> doing.

Here's another example to follow, the Buffalo DNS-32[05]:

First patch is here:

http://www.spinics.net/lists/arm-kernel/msg166774.html

Converting the nand driver and using it is here:

http://www.spinics.net/lists/arm-kernel/msg167308.html

hth,

Jason.
