From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 4 Jun 2014 18:48:41 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: enable i2c0 and i2c2
In-Reply-To: <20140603080522.GB22742@lunn.ch>
References: <1401780790-17830-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401780790-17830-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140603080522.GB22742@lunn.ch>
Message-ID: <20140604164841.GA12859@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Jun 03, 2014 at 10:05:22AM +0200, Andrew Lunn wrote:
> On Tue, Jun 03, 2014 at 09:33:10AM +0200, Antoine T?nart wrote:
> > Enable the I2C0 and I2C2 for the Marvell Berlin BG2G DMP. I2C1 and I2C3
> > are also working on this board, but no devices seemed to be there.
> 
> Does this mean that IC0 and I2C2 have devices on them? Could you also
> add nodes for the devices?

No devices I can add for now. I you prefer we can drop this patch, keep
the other one and enable i2c nodes for the BG2Q DMP when they will be
needed.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
