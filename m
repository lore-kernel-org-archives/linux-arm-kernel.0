From: nm@ti.com (Nishanth Menon)
Date: Thu, 12 May 2016 14:19:49 -0500
Subject: [PATCH] ARM: OMAP5 / DRA7: Introduce workaround for 801819
In-Reply-To: <20160512171244.GT5995@atomide.com>
References: <1438876464-15424-1-git-send-email-nm@ti.com>
 <20160512171244.GT5995@atomide.com>
Message-ID: <5734D755.3040406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 12:12 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [150806 08:57]:
>> Add workaround for Cortex-A15 ARM erratum 801819 which says in summary
>> that "A livelock can occur in the L2 cache arbitration that might
>> prevent a snoop from completing. Under certain conditions this can
>> cause the system to deadlock. "
> 
> Thanks for the late reminder, this has totally fallen through the
> cracks. Applying into omap-for-v4.7/fixes. Once merged to mainline,
> it can be requested for stable if needed.

Thanks for digging this out.


-- 
Regards,
Nishanth Menon
