From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 9 Aug 2011 10:58:56 +0100
Subject: [PATCH 00/13] Clean up mach/gpio.h headers
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Message-ID: <20110809095856.GF3210@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Aug 09, 2011 at 09:04:12AM +0100, Russell King - ARM Linux wrote:
> This is a preliminary posting of my gpio patch set.
> 
> This patch series moves the trivial gpiolib implementations out of
> mach/gpio.h and into asm/gpio.h.
> 
> As a side effect of that, most of this patch series is about fixing up
> direct includes of mach/gpio.h - this is something I've been on at
> people over the last year or more about ensuring that they use
> linux/gpio.h in preference.  While I've blindly converted all arch/arm
> to use linux/gpio.h (with the exception of mach/ includes which are
> converted to asm/gpio.h), drivers were only converted to asm/gpio.h.
> These should be reviewed and changed to linux/gpio.h.
> 
> As a result of this patch series, several mach/gpio.h end up being
> empty.

Nice series!  This gives me an empty gpio.h for picoxcell.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
