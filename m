From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 20 Oct 2012 21:08:24 -0400
Subject: [PATCH] [ARM] Enable the second I2C bus on Marvell Kirkwood
In-Reply-To: <20121001235932.GA678@obsidianresearch.com>
References: <20121001235932.GA678@obsidianresearch.com>
Message-ID: <20121021010824.GC25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 05:59:32PM -0600, Jason Gunthorpe wrote:
> mv64xxx_of_config requires that the tclk frequency be found
> through the clk stuff rather than through device tree, so add
> another override for the 2nd controller.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

I made one small change, changed subject to:

ARM: Kirkwood: Enable the second I2C bus

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

thx,

Jason.
