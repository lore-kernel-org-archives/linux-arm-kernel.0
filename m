From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Aug 2012 15:52:10 +0100
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <20120815121801.GD22226@titan.lakedaemon.net>
References: <20120815085709.GI18957@n2100.arm.linux.org.uk>
 <20120815121801.GD22226@titan.lakedaemon.net>
Message-ID: <20120815145210.GA32560@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 08:18:01AM -0400, Jason Cooper wrote:
> On Wed, Aug 15, 2012 at 09:57:09AM +0100, Russell King - ARM Linux wrote:
> > +#ifdef CONfig_PCI
> 
> ummm...   ^^^^^^ is this a typo?  (/me dives into a trench)

No, it's your imagination playing tricks again. :)  I'll get a new patch
out when I'm in a state that I can redo the git commit without destroying
the current state of my development git tree.

(which may be a while as I'm trying to sort out why ubuntu 12.04 userspace
seems to be a total disaster on the cubox.)
