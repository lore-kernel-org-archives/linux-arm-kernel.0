From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Jun 2016 10:56:52 +0200
Subject: [RFC PATCH 12/15] irqchip/s3c24xx: fixup IO accessors for big
 endian
In-Reply-To: <20160608183110.13851-13-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-13-matthew@mattleach.net>
Message-ID: <5763BB54.5040202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 08:31 PM, Matthew Leach wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Instead of using the __raw accesors, use the _relaxed versions
> to deal with any issues due to endian-ness of the CPU.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> ---
> CC: Thomas Gleixner <tglx@linutronix.de> (maintainer:IRQCHIP DRIVERS)
> CC: Jason Cooper <jason@lakedaemon.net> (maintainer:IRQCHIP DRIVERS)
> CC: Marc Zyngier <marc.zyngier@arm.com> (maintainer:IRQCHIP DRIVERS)
> CC: linux-kernel at vger.kernel.org (open list:IRQCHIP DRIVERS)
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/irqchip/irq-s3c24xx.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
