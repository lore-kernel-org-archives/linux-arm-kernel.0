From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jun 2014 10:35:16 +0100
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17
In-Reply-To: <20140628172044.4231c32d@free-electrons.com>
References: <20140627124655.GF23978@titan.lakedaemon.net>
 <20140628162302.48b6b835@free-electrons.com>
 <20140628150706.GM23978@titan.lakedaemon.net>
 <20140628172044.4231c32d@free-electrons.com>
Message-ID: <20140629093515.GM32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 05:20:44PM +0200, Thomas Petazzoni wrote:
> On Sat, 28 Jun 2014 11:07:06 -0400, Jason Cooper wrote:
> > > >     - don't apply thermal quirk by default
> > > >     - make Aramada 375 external abort logic a quirk
> > > >     - update L2/PCIe deadlock workaround after L2CC cleanup
> > > 
> > > This patch is needed in 3.16, not in 3.17. They really are bug fixes,
> > > fixing a complete system deadlock under PCI load.
> > 
> > crap.  :(  Ok, guys, please ignore this pull request and I'll send a new
> > one with this done properly.
> > 
> > Thomas, you say 'patch', but you quote three.  Should all three be in
> > mvebu/fixes?  Or, just the last one?
> 
> Yeah, sorry, I wasn't clear. If you look back at what I sent in
> https://www.mail-archive.com/devicetree at vger.kernel.org/msg30473.html
> ([PATCHv5 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
> deadlock), there were three patches:
> 
>  PATCH 1/3, "ARM: mm: add support for HW coherent systems in PL310
>  cache", for Russell. It has already been merged by Russell in
>  "git-curr", as visible at
>  http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8076/1.
>  I'm hoping this is scheduled for 3.16, because I need this patch for
>  3.16 to avoid the PCIe deadlock.

I'll move it in for the next -rc merge.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
