From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jan 2017 14:09:45 +0100
Subject: [PATCHv2 0/5] Support for Marvell switches with integrated CPUs
In-Reply-To: <185147a37cab4d7eaea5f79d86cc9451@svr-chch-ex1.atlnz.lc>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <6c6795d3-06ab-a4f0-78ad-5ecc78c1aa2f@gmail.com>
 <185147a37cab4d7eaea5f79d86cc9451@svr-chch-ex1.atlnz.lc>
Message-ID: <20170105130945.GA18033@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'd love to see a switchdev driver but it's a huge task (and no I'm not 
> committing to writing it). As it stands Marvell ship a switch SDK 
> largely executes in userspace with a small kernel module providing some 
> linkage to the underlying hardware.

Is there any similarity to the mv88e6xxx family?

If it was similar registers, just a different access mechanising, we
could probably extend the mv88e6xxx to support MMIO as well as MDIO.

   Andrew
