From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Oct 2013 16:34:49 +0200
Subject: [PATCH v3 07/14] ARM: mvebu: Add a new set of registers for pmsu
In-Reply-To: <1381759106-15004-8-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
 <1381759106-15004-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20131014163449.5944e087@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:19 +0200, Gregory CLEMENT wrote:
> The Power Management Unit Service block also controls the Coherency
> Fabric subsystem. This new set of registers is needed for the CPU idle
> implementation for the Armada 370/XP, it allows to enter a deep CPU
> idle state where the Coherency Fabric and the L2 cache are power down.

power -> powered

> This patch also adds warnings if one of the base registers set can't
> be ioremapped.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I believe the Device Tree binding documentation should be updated in
this patch (which actually changes the driver offering the binding),
rather than in PATCH 14/14 (which updates the particular DT of a given
platform to use this new binding).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
