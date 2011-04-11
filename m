From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 17:00:29 +0100
Subject: [RFC PATCH 2/5] sa1100: convert to basic-mmio-gpio
In-Reply-To: <1302522502-24381-3-git-send-email-jamie@jamieiles.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<1302522502-24381-3-git-send-email-jamie@jamieiles.com>
Message-ID: <20110411160029.GE21449@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 12:48:19PM +0100, Jamie Iles wrote:
> The basic-mmio-gpio driver is capable of supporting this controller so
> convert the platform to use it for basic GPIO support.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---

So this is the same as plat-mxc in that the gpio initialization is being 
called from .init_irq and some of the .init_machine calls need to use 
GPIOs.

Jamie
