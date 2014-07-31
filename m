From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Jul 2014 16:15:29 +0200
Subject: [PATCH] ARM: mvebu: Add RTC support for Armada 375
In-Reply-To: <1406814276-11361-1-git-send-email-gregory.clement@free-electrons.com>
References: <1406814276-11361-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140731161529.09c55afb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 31 Jul 2014 15:44:36 +0200, Gregory CLEMENT wrote:

> The Armada 375 XP Socs have the same controller that the one used in
> the orion platforms. This patch updates the device tree for these
> SoCs.

Actually there's only one Armada 375 SoC, so singular would be good.
And s/that/than/ as well. And "controller" is a bit vague. Proposal:

"""
The Armada 375 SoC has the same real time clock as the one used in
other Marvell EBU platforms. This patch consequently updates the Device
Tree of the Armada 375 SoC to describe the internal RTC.
"""

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
