From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 16 Nov 2017 22:05:53 +0100
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
In-Reply-To: <20171116193145.s2nja2kfevjxlnt5@pd.tnic>
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
 <20171116193145.s2nja2kfevjxlnt5@pd.tnic>
Message-ID: <20171116210553.GA19214@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> and that driver depends on ARCH_MVEBU which is arm64, AFAICT.

ARCH_MVEBU is both 32 and 64. It refers more to a collection of
devices which mvebu processor have. Some of these processors are
32bit, some are 64bit.

	   Andrew
