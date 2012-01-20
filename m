From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jan 2012 12:48:52 +0000
Subject: [PATCH v4 11/15] ARM: imx6q: convert to twd_local_timer_register()
 interface
In-Reply-To: <20120120124116.GC25917@S2101-09.ap.freescale.net>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-12-git-send-email-marc.zyngier@arm.com>
 <20120120124116.GC25917@S2101-09.ap.freescale.net>
Message-ID: <4F1962B4.7040308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/12 12:41, Shawn Guo wrote:
> On Fri, Jan 20, 2012 at 12:03:58PM +0000, Marc Zyngier wrote:
>> Add support for the new smp_twd runtime registration interface
>> to the imx6q platforms, and remove the old compile-time support.
>>
>> The imx6q DTS file is updated to match the TWD DT documentation.
>> Also present in this patch a DTS fix to the timer interrupt routing
>> (the PPI connection uses bits [15:8]) and trigger (rising edge).
>>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I believe that I have acked this patch, and this patch has no change
> since v3.  So again,
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

I must have missed it. Thanks Shawn.

	M.
-- 
Jazz is not dead. It just smells funny...
