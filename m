From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 29 May 2013 09:42:36 +0200
Subject: [PATCH] arm: kirkwood: convert NETGEAR ReadyNAS Duo v2 to use
 DT for the PCIe interface
In-Reply-To: <20130528223817.GL31290@titan.lakedaemon.net>
References: <8738t6ycnm.fsf@natisbad.org> <20130529002053.4b8ceb86@skate>
 <20130528223817.GL31290@titan.lakedaemon.net>
Message-ID: <20130529094236.619bd698@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 28 May 2013 18:38:17 -0400, Jason Cooper wrote:

> > Could you check that you're running on top of the latest
> > jcooper/mvebu/pcie branch? Thanks!
> 
> Actually, you want jcooper/mvebu/pcie_kirkwood.  I split out the
> kirkwood driver so that if it causes a build breakage and gets dropped,
> mvebu/pcie can still go in.

There's not really a "kirkwood" driver for PCIe. The pcie-kirkwood
stuff is really all about adding the right Device Tree informations,
and switching from a legacy-style probing to a DT-style probing.

That said, I definitely agree with the idea of having that as a
separate branch.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
