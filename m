From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 31 Jan 2013 17:22:54 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <510A689B.6040407@free-electrons.com>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <20130130173306.GO7717@titan.lakedaemon.net>
 <510959D5.1010305@free-electrons.com>
 <20130130181035.GP7717@titan.lakedaemon.net>
 <510A5E87.60509@free-electrons.com>
 <20130131124542.GB7717@titan.lakedaemon.net>
 <510A689B.6040407@free-electrons.com>
Message-ID: <20130131162254.GD20242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Well in fact it is 4GB RAM but we can only use 3GB (we need the last GB
> of address space for peripheral, CPU registers and IOmem).

Hi Gregory

Does the CPU support Large Physical Addressing, LPA? Is that on the
roadmap for Armada?

	Andrew
