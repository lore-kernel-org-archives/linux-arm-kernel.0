From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 18:07:56 +0100
Subject: [PATCH] ARM: Kconfig: Do not select ARCH_VEXPRESS on ARCH_MULTI_V7
In-Reply-To: <1353344339.3303.36.camel@hornet>
References: <1353343080-19220-1-git-send-email-fabio.estevam@freescale.com>
 <1353343497.3303.34.camel@hornet> <20121119175440.1096f725@skate>
 <1353344339.3303.36.camel@hornet>
Message-ID: <20121119180756.21c3ef6a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 19 Nov 2012 16:58:59 +0000, Pawel Moll wrote:

> I'm not arguing this. As far as I remember Rob wanted to make vexpress a
> default for the multiplatform kernel, but you're right saying that
> forcing it with the SELECT was probably a step too far.

IIRC, the problem is that we need at least one platform to be enabled,
otherwise it doesn't build, but I might be wrong.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
