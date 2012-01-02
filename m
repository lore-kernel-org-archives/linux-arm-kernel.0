From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 12:14:28 +0000
Subject: [PATCHv2 1/2] gpio: add a driver for the Synopsys DesignWare
 APB GPIO block
In-Reply-To: <4EFE1E35.106@gmail.com>
References: <1324345431-12251-1-git-send-email-jamie@jamieiles.com>
 <20111230195955.GA3427@page> <4EFE1E35.106@gmail.com>
Message-ID: <20120102121428.GA18443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 02:25:25PM -0600, Rob Herring wrote:

> We've got to sort out getting irq domains enabled on x86 and MIPS in
> order to merge generic irq chip using domains. I'm not sure that will
> get done in time.

> Can you leave out the interrupt portion of the driver? Or that is needed
> to get to a useful state.

Or just add a dependency in Kconfig?
