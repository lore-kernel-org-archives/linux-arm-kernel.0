From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 23 Jan 2013 13:58:47 +0000
Subject: [PATCH v1 0/6] USB: Add support for multiple PHYs of same type
In-Reply-To: <B9531499-0746-44DA-BDBB-999D4CA31E63@dominion.thruhere.net>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <2D906ABA-71F2-4843-9DBE-F82527A1240A@dominion.thruhere.net>
 <50FEB3FD.3050001@ti.com> <50FEBB61.9000707@ti.com>
 <B9531499-0746-44DA-BDBB-999D4CA31E63@dominion.thruhere.net>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA922F5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Koen,

On Tue, Jan 22, 2013 at 22:32:56, Koen Kooi wrote:
 
> Actually it uses nop-phy as a phy, which is missing from arch/arm/boot/dts/am33xx.dtsi, so mainline is already broken. But adding the nop-phy to the DT is easy enough to patch in locally.

USB first instance of am335x works in mainline as of now.

Regards
Afzal
