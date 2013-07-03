From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 03 Jul 2013 10:03:40 -0400
Subject: Proposal: mach-dt
In-Reply-To: <51D3ECD1.8030305@arm.com>
References: <1372839486.487159774@f54.mail.ru> <51D3ECD1.8030305@arm.com>
Message-ID: <51D42F3C.3020805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2013 05:20 AM, Marc Zyngier wrote:
> On 03/07/13 09:18, Alexander Shiyan wrote:
> 
> Hi Alexander,
> 
>> More and more platforms are now using devicetree.
>> Ideally the platform code contains only one function "of_platform_populate".
>> My idea is to make a generic architecture (mach-dt) with the call then add support
>> for compatible subarchitectures as they become available in "compatible"-property.
>> Your opinion?
> 
> Well, my (admittedly partial) opinion is that mach-virt is an incredibly
> nicer sounding name, 'specially as you can mistype it as mach-triv.

As mentioned before, I disagree and would love to see the the
virtualization-specific name replaced by something more suitably generic.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
