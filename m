From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 10:23:23 +0000
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130213103121.5f6338ef@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302130918.56909.arnd@arndb.de> <20130213103121.5f6338ef@skate>
Message-ID: <201302131023.24012.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Thomas Petazzoni wrote:
> > I guess as long as we agree on where we are headed with the
> > address translation, it's ok to just move the code now and
> > change the code later. I would like to be strict about the
> > include path stuff though.
> 
> Ok, so I could move the existing address decoding code into say
> drivers/bus/orion-mbus.c. Would that be ok for you?

Sure, sounds good to me.

	Arnd
