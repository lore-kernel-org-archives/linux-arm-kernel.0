From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 May 2015 12:08:48 -0700
Subject: [PATCH] Show proper respect for Heinrich Hertz by using the
 correct unit for frequency
In-Reply-To: <20150511131952.GD2067@n2100.arm.linux.org.uk>
References: <20150511131952.GD2067@n2100.arm.linux.org.uk>
Message-ID: <20150511190847.GE15563@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150511 06:23]:
> The SI unit of frequency is Hertz, named after Heinrich Hertz, and is
> given the symbol "Hz" to denote this.  "hz" is not the unit of frequency,
> and is in fact meaningless.
> 
> Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich Hertz
> contribution to the modern world.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
