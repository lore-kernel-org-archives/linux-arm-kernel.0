From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 16 Jul 2011 00:28:51 -0700
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states
	as ON at init
In-Reply-To: <alpine.DEB.2.00.1107150152590.16606@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1107150152590.16606@utopia.booyaka.com>
Message-ID: <4E213DB3.1080809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/15/2011 12:54 AM, Paul Walmsley wrote:
> On Wed, 13 Jul 2011, Santosh Shilimkar wrote:
>
>> From: Rajendra Nayak<rnayak@ti.com>
>>
>> Program all powerdomain target state as ON; This is to
>> prevent domains from hitting low power states (if bootloader
>> has target states set to something other than ON) and potentially
>> even losing context while PM is not fully initilized.
>> The PM late init code can then program the desired target
>> state for all the power domains.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Thanks, dropped the second hunk of the patch and queued for 3.1-rc fixes
> at git://git.pwsan.com/linux-2.6 in the 'pwrdm_clkdm_fixes_3.1rc' branch.
>
> Santosh, looks like this is missing a Signed-off-by: or similar from you.
> Do you want me to add it?
>
Sure Paul. I missed to add it somehow while posting it.

Regards
Santosh
