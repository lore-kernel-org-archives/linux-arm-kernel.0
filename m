From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 30 Apr 2018 15:44:37 +0200
Subject: [PATCH 02/17] arm64: dts: marvell: fix CP110 ICU node size
In-Reply-To: <20180421135537.24716-3-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-3-miquel.raynal@bootlin.com>
Message-ID: <20180430154437.59025f2e@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:22 +0200, Miquel Raynal wrote:
> ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
> specification).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
