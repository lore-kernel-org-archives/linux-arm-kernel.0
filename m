From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Aug 2012 18:30:26 +0200
Subject: [RFC 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <20120808151946.GE4579@mudshark.cambridge.arm.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
 <20120808151946.GE4579@mudshark.cambridge.arm.com>
Message-ID: <50229422.40305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 05:19 PM, Will Deacon wrote:
> On Wed, Aug 08, 2012 at 04:05:03PM +0100, Gregory CLEMENT wrote:
>> +static void aurora_pa_range(unsigned long start, unsigned long end,
>> +                       unsigned long offset)
>> +{
> 
> This controller is used by Armada XP right? I think that SoC supports LPAE,
> so please tell me that the above is a mistake and the controller can support
> physical addresses > 32 bits!

Yes indeed this SoC support LPAE.

> 
> If so, you'll need to hack the cache-l2x0 driver to use phys_addr_t types
> instead of unsigned longs.

Ok I will look at this.

> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
