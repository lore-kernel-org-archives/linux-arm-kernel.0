From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 31 Jan 2013 17:38:14 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <20130131162254.GD20242@lunn.ch>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <20130130173306.GO7717@titan.lakedaemon.net>
 <510959D5.1010305@free-electrons.com>
 <20130130181035.GP7717@titan.lakedaemon.net>
 <510A5E87.60509@free-electrons.com>
 <20130131124542.GB7717@titan.lakedaemon.net>
 <510A689B.6040407@free-electrons.com>
 <20130131162254.GD20242@lunn.ch>
Message-ID: <20130131163814.GE20242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 05:22:54PM +0100, Andrew Lunn wrote:
> > Well in fact it is 4GB RAM but we can only use 3GB (we need the last GB
> > of address space for peripheral, CPU registers and IOmem).
> 
> Hi Gregory
> 
> Does the CPU support Large Physical Addressing, LPA? Is that on the
> roadmap for Armada?

I did a bit of googling:

http://www.linleygroup.com/newsletters/newsletter_detail.php?num=3982

	To address the cloud-computing market, the company added
	40-bit physical addressing to Armada XP, using a method
	similar to what ARM implemented in Cortex-A15. This feature
	allows the memory controller to support up to one terabyte
	(1TB) of DRAM.

Also:

http://www.theregister.co.uk/2012/10/24/dell_zinc_arm_server_apache_software/

talks about 40-bit.

So it should be possible to use the full 4GBytes of RAM, in theory.

   Andrew
