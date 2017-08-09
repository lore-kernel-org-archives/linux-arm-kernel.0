From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Wed, 9 Aug 2017 14:31:42 +0200
Subject: [PATCH] ARM64: dts: a7040: add regulator nodes to enable USB
 host VBUS
In-Reply-To: <20170809140538.692b3e6d@windsurf>
References: <20170809081949.24343-1-miquel.raynal@free-electrons.com>
 <20170809140538.692b3e6d@windsurf>
Message-ID: <20170809143142.6f9d500d@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Aug 2017 14:05:38 +0200
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
> 
> On Wed,  9 Aug 2017 10:19:49 +0200, Miquel Raynal wrote:
> > From: Hanna Hawa <hannah@marvell.com>
> > 
> > Add I2C expander and USB host PHY (host 0 and host 1) to enable
> > USB VBUS on USB ports of type A on Armada-7040-DB.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>  
> 
> You should have kept Hanna's Signed-off-by here and add your own below
> it.
> 
> The author of the patch should always match the first person signing
> off on the patch.

Right, I will correct that, thank you.

Regards,
Miquel

> 
> Best regards,
> 
> Thomas



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
