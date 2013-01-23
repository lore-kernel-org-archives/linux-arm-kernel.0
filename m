From: kishon@ti.com (kishon)
Date: Wed, 23 Jan 2013 19:56:37 +0530
Subject: [PATCH v1 0/6] USB: Add support for multiple PHYs of same type
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA922F5@DBDE01.ent.ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <2D906ABA-71F2-4843-9DBE-F82527A1240A@dominion.thruhere.net>
 <50FEB3FD.3050001@ti.com> <50FEBB61.9000707@ti.com>
 <B9531499-0746-44DA-BDBB-999D4CA31E63@dominion.thruhere.net>
 <C8443D0743D26F4388EA172BF4E2A7A93EA922F5@DBDE01.ent.ti.com>
Message-ID: <50FFF31D.2070908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On Wednesday 23 January 2013 07:28 PM, Mohammed, Afzal wrote:
> Hi Koen,
>
> On Tue, Jan 22, 2013 at 22:32:56, Koen Kooi wrote:
>
>> Actually it uses nop-phy as a phy, which is missing from arch/arm/boot/dts/am33xx.dtsi, so mainline is already broken. But adding the nop-phy to the DT is easy enough to patch in locally.
>
> USB first instance of am335x works in mainline as of now.

Can you check if this series indeed breaks am335x?

Thanks for your help.

Regards
Kishon
