From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 12:27:01 +0000
Subject: [PATCHv2 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <20120102122400.GA6124@page>
References: <1324345431-12251-1-git-send-email-jamie@jamieiles.com>
 <20111230195955.GA3427@page> <4EFE1E35.106@gmail.com>
 <20120102121428.GA18443@sirena.org.uk> <20120102122400.GA6124@page>
Message-ID: <20120102122700.GJ2899@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 12:24:00PM +0000, Jamie Iles wrote:

> The IRQ part is dependent on Rob's patches to introduce irq domain 
> support into the generic chip though, so how about I split this into two 
> patches, one that does the basic GPIO stuff and another that does the 
> IRQ portion (with the dependency change) and if Rob's patches don't make 
> it in we drop the IRQ support for the GPIO?

Yeah, epecially since the IRQ domain stuff is still giving unbootable
kernels in -next as far as I know.
