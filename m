From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Nov 2012 17:16:15 +0000
Subject: ttySAC0 or ttyS0 in 3.6.x ARM Linux?
In-Reply-To: <k824bb$7kp$1@ger.gmane.org>
References: <k824bb$7kp$1@ger.gmane.org>
Message-ID: <20121115171615.GP3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 03:07:24PM +0800, woody wrote:
> In the 3.6.6 ARM kernel, should I use ttySAC0 or ttyS0 to specify the  
> 'console' kernel command line?

That depends on what type of UART you're using.  ttyS is for 8250 ports.
ttySAC ended up being used for various SoC based ports which aren't
8250 based.
