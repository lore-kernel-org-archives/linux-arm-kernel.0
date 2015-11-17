From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Nov 2015 17:34:36 +0000
Subject: [PATCH v11 4/5] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <20151117172914.GL30101@arm.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1511101410550.5676@kaball.uk.xensource.com>
 <20151117172914.GL30101@arm.com>
Message-ID: <564B652C.8060409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 17:29, Will Deacon wrote:
> On Tue, Nov 10, 2015 at 02:11:38PM +0000, Stefano Stabellini wrote:
>> On Thu, 5 Nov 2015, Stefano Stabellini wrote:
>>> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
>>> Necessary duplication of paravirt.h and paravirt.c with ARM.
>>>
>>> The only paravirt interface supported is pv_time_ops.steal_clock, so no
>>> runtime pvops patching needed.
>>>
>>> This allows us to make use of steal_account_process_tick for stolen
>>> ticks accounting.
>>>
>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Ping?
>>
>> Catalin, Will,
>> are you happy with this change?
> 
> I'm happy if Marc's happy. Marc?

My Ack is already on the tin! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
