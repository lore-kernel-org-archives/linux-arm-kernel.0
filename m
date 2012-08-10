From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Aug 2012 17:13:41 +0200
Subject: [RFC 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <20120810144922.GH2066@mudshark.cambridge.arm.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
 <20120808151946.GE4579@mudshark.cambridge.arm.com>
 <50229422.40305@free-electrons.com> <50229944.60603@free-electrons.com>
 <20120810144922.GH2066@mudshark.cambridge.arm.com>
Message-ID: <50252525.8050602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 04:49 PM, Will Deacon wrote:
> On Wed, Aug 08, 2012 at 05:52:20PM +0100, Gregory CLEMENT wrote:
>> On 08/08/2012 06:30 PM, Gregory CLEMENT wrote:
>>> Yes indeed this SoC support LPAE.
>>
>> Well Armada XP supports LPAE but don't use any outer cache functions, he works
>> with the Aurora cache controller on 'system cache'.
>> Armada 370 uses this outer cache functions but doesn't support LPAE.
> 
> Can the Armada 370 be configured to use the co-processor interface to the
> L2, or does only the Armada XP support that feature? What happens if you
> build a single zImage supporting both of the SoCs?

About L2 cache we already use the same kernel on Armada 370 and Armada XP
and the differences are in the device tree.

Now if I understood correctly what the LPAE involved, I guess we can't have
a kernel with LAPE running on Armada 370.

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
