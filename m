From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 1 Mar 2012 21:32:39 +0100
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <201203011825.44049.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201203011352.36067.arnd@arndb.de>
 <20120301140817.GG7363@n2100.arm.linux.org.uk>
 <201203011825.44049.arnd@arndb.de>
Message-ID: <20120301203239.GA10854@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That leaves us still with Kirkwood/Dove and ixp2000 to figure out.
> 
...
> 
> For Kirkwood and Dove, an easy way out would be to extend the I/O
> space window to 2MB right away and just map both as before, but we
> can also try just using the two lower 64k windows in each and see what
> breaks, as those seem to be widely available for testing still.

I have two different kirkwood devices i can test with. Unfortunately,
only one has a pcie devices, an Atheros wireless card. I might be able
to test the machine without any pcie devices tomorrow, but the
interesting device will have to wait until next week.

	    Andrew
