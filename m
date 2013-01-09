From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Jan 2013 14:48:48 +0000
Subject: [PATCH 0/2] HYP boot mode fixes
In-Reply-To: <20130109144614.GB32463@mudshark.cambridge.arm.com>
References: <1357321455-9264-1-git-send-email-marc.zyngier@arm.com>
 <20130109144614.GB32463@mudshark.cambridge.arm.com>
Message-ID: <50ED8350.7080705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/13 14:46, Will Deacon wrote:
> Hi Marc,
> 
> On Fri, Jan 04, 2013 at 05:44:13PM +0000, Marc Zyngier wrote:
>> Here's a couple of patches fixing issues that have been recently
>> brought to my attention.
>>
>> The first patch only affects configurations that are already broken
>> (CPUs entering the kernel with different modes). The second one is a
>> bit more serious, and potentially affects setups where the secondary
>> core is brought up using an interrupt that is still pending when the
>> kernel is entered.
>>
>> Both patches have been tested on TC2, and are based on v3.8-rc2.
> 
> I've been collecting hyp-boot patches since before Christmas so, if it's
> alright with you, I'll take these into the branch I currently have and send
> that lot via Russell. Check my virt/hyp-boot branch if you're interested.

Please do. You may want to Cc stable on the second one, as it fixes a
observable issue.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
