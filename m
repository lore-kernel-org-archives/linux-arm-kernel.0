From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 18:53:04 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <20140413155949.GG10033@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413154715.GE10033@lunn.ch> <20140413175658.64b65a76@skate>
 <20140413155949.GG10033@lunn.ch>
Message-ID: <20140413185304.358c1c42@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 13 Apr 2014 17:59:49 +0200, Andrew Lunn wrote:

> I hope kirkwood will complete its move soon. I have Openrd in a state
> it can move to mvebu, So that only leaves netxbig_v2.c.

Nice, that would be a good move. Regarding netxbig_v2.c, looks like I
need to revive
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/188443.html.

On the mach-dove front, what is preventing the removal of the old style
cm-a510.c and dove-db-setup.c, since I see there are Device Tree for
those platforms? Maybe they are not complete? Maybe the biggest problem
is testing PCIe?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
