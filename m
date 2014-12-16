From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Dec 2014 20:03:04 +0000
Subject: [PATCH 08/27] ARM: mvebu: armada-370-xp: Relicense the device
 tree under GPLv2+/X11
In-Reply-To: <20141216185550.GQ967@titan.lakedaemon.net>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <1418657915-22775-9-git-send-email-gregory.clement@free-electrons.com>
 <20141215232221.GD19261@kw.sim.vm.gnt>
 <20141216130331.GJ967@titan.lakedaemon.net>
 <20141216133719.GE19261@kw.sim.vm.gnt>
 <20141216144533.GL967@titan.lakedaemon.net>
 <54907A82.6030906@free-electrons.com>
 <20141216185550.GQ967@titan.lakedaemon.net>
Message-ID: <20141216200304.GS11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 01:55:50PM -0500, Jason Cooper wrote:
> Agreed.  We should keep in mind that once we have heard from everybody
> (big if), that is still only representative of armada and maybe mvebu
> ecosystem. :(  I'm starting to lean even more towards #2...

Except I know that there are people out there who want to ship the
source files with their project.

The DT source files are integrated into the mainline Linux kernel, and
not everyone wants to download the Linux kernel source just to be able
to build the DT files for their non-Linux project.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
