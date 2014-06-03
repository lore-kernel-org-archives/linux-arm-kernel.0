From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jun 2014 10:05:22 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: enable i2c0 and i2c2
In-Reply-To: <1401780790-17830-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1401780790-17830-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401780790-17830-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140603080522.GB22742@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 09:33:10AM +0200, Antoine T?nart wrote:
> Enable the I2C0 and I2C2 for the Marvell Berlin BG2G DMP. I2C1 and I2C3
> are also working on this board, but no devices seemed to be there.

Hi Antoine

Does this mean that IC0 and I2C2 have devices on them? Could you also
add nodes for the devices?

    Andrew
