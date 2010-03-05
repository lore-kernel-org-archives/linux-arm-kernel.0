From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 22:36:34 +0000
Subject: [PATCH] ARM: Add Versatile Express support
In-Reply-To: <000101cabc6f$b54b4080$1fe1c180$@tuckley@arm.com>
References: <git-1267729916-9e7380877e37e33ffe507b0299aa4c6e9cac599e@rmk-PC>
	<git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<000101cabc6f$b54b4080$1fe1c180$@tuckley@arm.com>
Message-ID: <20100305223634.GA20095@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 02:25:29PM -0000, Colin Tuckley wrote:
> For some reason you seem to have renamed the "System Register Interface" to
> "configuration register interface"

No I have not - I'm using the terminology found in the ARM documentation:

Configuration Data Register, SYS_CFG registers

The SYS_CFG registers enable communication between the MCC and DCC to
read and write a variety of system parameters, for example:
 ? oscillators
 ? voltage
 ? current
 ? power.
...

There's many more references to these being 'configuration' registers
in the user guides for these boards.  I see no sign of it being called
by any different name.

Maybe the documentation on the ARM website is out of date?  In any case,
it would seem that I'm using the publically documented names for these
interfaces.
