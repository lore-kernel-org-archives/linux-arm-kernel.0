From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 13:55:56 +0200
Subject: [PATCH 1/2] arm: plat-orion: Add coherency attribute when setup
 mbus target
In-Reply-To: <1351065841-18654-2-git-send-email-gregory.clement@free-electrons.com>
References: <1351065841-18654-1-git-send-email-gregory.clement@free-electrons.com>
 <1351065841-18654-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121024135556.157d2e59@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 24 Oct 2012 10:04:00 +0200, Gregory CLEMENT wrote:
> Recent SoC such as Armada 370/XP came with the possibility to deal
> with the I/O coherency by hardware. In this case the transaction
> attribute of the window must be flagged as "Shared transaction". Once
> this flag is set, then the transactions will be forced to be sent
> through the coherency block, in other case transaction is driven
> directly to DRAM.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Yehuda Yitschak <yehuday@marvell.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
