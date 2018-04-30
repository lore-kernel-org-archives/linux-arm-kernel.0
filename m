From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 30 Apr 2018 15:44:19 +0200
Subject: [PATCH 01/17] dt-bindings/interrupt-controller: fix Marvell ICU
 length in the example
In-Reply-To: <20180421135537.24716-2-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-2-miquel.raynal@bootlin.com>
Message-ID: <20180430154419.29212212@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:21 +0200, Miquel Raynal wrote:
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
