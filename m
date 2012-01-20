From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jan 2012 12:49:07 +0000
Subject: [PATCH v4 05/15] ARM: OMAP4: convert to twd_local_timer_register()
 interface
In-Reply-To: <20120120124302.GK22818@atomide.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-6-git-send-email-marc.zyngier@arm.com>
 <20120120124302.GK22818@atomide.com>
Message-ID: <4F1962C3.4030405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/12 12:43, Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [120120 03:31]:
>> Add support for the new smp_twd runtime registration interface
>> to the OMAP4 platforms, and remove the old compile-time support.
>> Tested on Panda.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks Tony.

	M.
-- 
Jazz is not dead. It just smells funny...
