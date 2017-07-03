From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 3 Jul 2017 09:42:56 +0200
Subject: ARM: sunxi: "Unbalanced enable for IRQ 0" warning on A20
In-Reply-To: <20170701140634.GC4902@n2100.armlinux.org.uk>
References: <aa19551d-c0dc-07c0-313a-d55dbda4d5ad@suse.de>
 <20170701140634.GC4902@n2100.armlinux.org.uk>
Message-ID: <514bab9a-e414-7635-65e2-d2a604f7011a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On 01/07/2017 16:06, Russell King - ARM Linux wrote:
> On Sat, Jul 01, 2017 at 12:51:57PM +0200, Andreas F?rber wrote:
>> [   33.683928] thermal thermal_zone0: failed to read out thermal zone (-110)
>> [   33.690870] ------------[ cut here ]------------
>> [   33.690901] WARNING: CPU: 0 PID: 161 at ../kernel/irq/manage.c:529
>> __enable_irq+0x54/0x88
>> [   33.690905] Unbalanced enable for IRQ 0
> 
> Why do we have new platforms using IRQ number 0 ?  0 for modern platforms
> is supposed to mean "no IRQ".
> 

Thanks for reporting, I'll look into it.

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
