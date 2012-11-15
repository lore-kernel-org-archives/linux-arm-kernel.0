From: davem@davemloft.net (David Miller)
Date: Wed, 14 Nov 2012 21:59:22 -0500 (EST)
Subject: [PATCH v7] Network driver for the Armada 370 and Armada XP ARM
 Marvell SoCs
In-Reply-To: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121114.215922.1242337385782766449.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Wed, 14 Nov 2012 15:56:44 +0100

> The previous versions of this patch set have been sent on September
> 4th (v1), October 11th (v2), October 23rd (v3), October 26th (v4),
> November 12th (v5), November 13th (v6) and now comes the v7 of the
> driver. The number of comments over the last versions have been really
> small, and I would really appreciate if this driver could land into
> the 3.8 kernel release.

I can't apply this patch to net-next, because for one thing there
are missing dependencies.  For example, the file:

arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts

doesn't exist there, therefore patch #6 won't apply.
