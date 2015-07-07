From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 Jul 2015 08:46:04 +0100
Subject: [PATCH v5 1/2] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <559B8308.4000200@linaro.org>
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>	
 <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>	
 <557729A0.1030700@arm.com> <559A964D.30500@arm.com>
 <1436201874.22232.3.camel@infradead.org> <559B8308.4000200@linaro.org>
Message-ID: <559B83BC.5080309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/15 08:43, AKASHI Takahiro wrote:
> On 07/07/2015 01:57 AM, Geoff Levand wrote:
>> Hi Marc,
>>
>> On Mon, 2015-07-06 at 15:53 +0100, Marc Zyngier wrote:
>>> So this has now been a whole month since I reviewed this, and I haven't
>>> seen any repost of this series. Any hope to see this within a reasonable
>>> time frame? Or is it considered dead already?
>>
>> I was hoping to do some work on updating the base kexec patches
>> last week, but all my time was taken up but other things.  I'll
>> try to start on it this week.
> 
> I also have some update, and so will submit my patchset
> after Geoff. Pratyush's patch should also be synced.

Please coordinate between all of you and post a consistent series. It
was painful enough to review the KVM stuff independently of the rest of
the series, so I'd really really want to see a single series that
addresses the issue end to end.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
