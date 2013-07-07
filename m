From: rmallon@gmail.com (Ryan Mallon)
Date: Mon, 08 Jul 2013 09:18:10 +1000
Subject: [RFC PATCH 0/9] Clean up debugging support
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <51D9F732.6010206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/13 22:43, Russell King - ARM Linux wrote:
> This patch series cleans up some aspects of the LL debug support by:
> 
> - Removing the multi-level choice madness
> - Consolidating the 8250 debug UART support
> - Consolidating the PL01x debug UART support
> 
> The differences between the various 8250 debug UART implementations are:
> - Physical/Virtual addresses
> - Register offset shift
> - Access size
> - Flow control
> 

>  arch/arm/mach-ep93xx/include/mach/debug-macro.S    |   21 -

For ep93xx bits:

Acked-by: Ryan Mallon <rmallon@gmail.com>
