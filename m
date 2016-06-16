From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 16 Jun 2016 13:48:45 +0100
Subject: [PATCH] irqchip/bcm2836: make bcm2836_smp_boot_secondary static
In-Reply-To: <20160613011852.GI24391@io.lakedaemon.net>
References: <1465407697-8116-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160613011852.GI24391@io.lakedaemon.net>
Message-ID: <0c23b47a-f718-1024-c93a-be8b15e2cd48@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/16 02:18, Jason Cooper wrote:
> Hey Ben,
> 
> On Wed, Jun 08, 2016 at 06:41:37PM +0100, Ben Dooks wrote:
>> The bcm2836_smp_boot_secondary() is not declared or used elsewhere
>> so make it static to fix the following warning:
>>
>> drivers/irqchip/irq-bcm2836.c:227:12: warning: symbol 'bcm2836_smp_boot_secondary' was not declared. Should it be static?
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  drivers/irqchip/irq-bcm2836.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This, and the rest of the irqchip/ ones, applied to irqchip/misc.

Thank you, so hopefully it'll be included in -next soon?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
