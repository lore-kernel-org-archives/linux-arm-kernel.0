From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jun 2017 14:52:12 +0200
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170605200107.7692-1-marc.zyngier@arm.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
Message-ID: <20170606145212.6524acde@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon,  5 Jun 2017 21:01:07 +0100, Marc Zyngier wrote:
> Enable the 1GB Ethernet interface that lives on the slave CP110,
> with its corresponding phy (that oddly lives on the master CP110).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
