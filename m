From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 20 May 2014 21:41:46 -0400
Subject: [PATCH 03/10] irqchip: versatile-fpga: add pass-thru enable
 support
In-Reply-To: <1400620176-7239-4-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-4-git-send-email-robherring2@gmail.com>
Message-ID: <20140521014146.GG8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, May 20, 2014 at 04:09:29PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Set the PIC_ENABLES register when the passthru-mask property is present.
> This enables interrupts on the secondary controller to be passed thru
> directly to the primary controller.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/irqchip/irq-versatile-fpga.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Patches 3 and 4 are good to go.  Shall I take them, or are they a
depended on by later patches?

thx,

Jason.
