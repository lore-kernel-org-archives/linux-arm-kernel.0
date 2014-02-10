From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Feb 2014 19:09:03 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140207160954.69fbca38@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <20140207093313.1a979a8f@skate>
 <20140207150306.GX8533@titan.lakedaemon.net>
 <20140207160954.69fbca38@skate>
Message-ID: <20140210180903.GF9995@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why not mvebu_v7 and mvebu_v5 as I suggested? mvebu_v7 would build both
> Dove and Armada 370/XP (and the other ones we are going to introduce
> soon), mvebu_v5 would build Kirkwood (and possibly Orion5x once I find
> enough time to work on this platform).

Hi Thomas

Could you produce a patch moving mvebu_defconfig to
mvebu_v7_defconfig? I will generate the mvebu_v5_defconfig based on
kirkwood_defconfig as part of my patchset.

Thanks
	Andrew


> 
> This way, ultimately we can simply remove kirkwood_defconfig and
> dove_defconfig, as soon as all legacy platforms have been either
> converted to DT, or removed.
> 
> Best regards,
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
