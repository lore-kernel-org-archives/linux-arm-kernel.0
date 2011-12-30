From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 30 Dec 2011 19:59:55 +0000
Subject: [PATCHv2 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <1324345431-12251-1-git-send-email-jamie@jamieiles.com>
References: <1324345431-12251-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111230195955.GA3427@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant, Linus,

On Tue, Dec 20, 2011 at 01:43:50AM +0000, Jamie Iles wrote:
> The Synopsys DesignWare block is used in some ARM devices (picoxcell)
> and can be configured to provide multiple banks of GPIO pins.  The first
> bank (A) can also provide IRQ capabilities.
> 
> v2:	- use Rob Herring's irqdomain in generic irq chip patches
> 	- use reg property to indicate bank index
> 	- support irqs on both edges based on LinusW's u300 driver
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Is this driver okay by you guys?  I'd like to get this one in for 3.3 if 
at all possible as it's the last patch that allows picoxcell to boot to 
a semi useful state without out of tree patches and that would make 
testing a lot easier!

Thanks,

Jamie
