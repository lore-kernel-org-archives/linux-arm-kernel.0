From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 22 Sep 2017 15:00:22 +0200
Subject: [PATCH v2] arm64: dts: marvell: Enable Armada-8040-DB CPS SPI1
In-Reply-To: <20170922125012.6715-1-miquel.raynal@free-electrons.com>
References: <20170922125012.6715-1-miquel.raynal@free-electrons.com>
Message-ID: <20170922130022.GA31634@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 02:50:12PM +0200, Miquel Raynal wrote:
> From: Christine Gharzuzi <chrisg@marvell.com>
> 
> Add the DT node enabling Armada-8040-DB CPS SPI controller driver.
> 
> Add the SPI NAND flash device connected on the bus. Fill the MTD
> partitions layout.
> 
> Signed-off-by: Christine Gharzuzi <chrisg@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---

Hi Miquel

Please put under the --- what you changed between v1 and v2. It helps
make the reviewing easier.

     Thanks
	Andrew
