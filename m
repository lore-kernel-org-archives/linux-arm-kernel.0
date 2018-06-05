From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Jun 2018 15:12:01 +0100
Subject: [PATCH 1/3] Revert "arm64: topology: divorce MC scheduling domain
 from core_siblings"
In-Reply-To: <CAMuHMdVPRLt34SUDsbbHvEG2OzvbJoT6id7Rb_2j32=zb1TuKg@mail.gmail.com>
References: <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
 <CAMuHMdVPRLt34SUDsbbHvEG2OzvbJoT6id7Rb_2j32=zb1TuKg@mail.gmail.com>
Message-ID: <36920292-9a04-9fe6-8a85-cc50b484dce5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/06/18 15:09, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Jun 5, 2018 at 3:55 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This reverts commit 37c3ec2d810f87eac73822f76b30391a83bded19.
>>
>> Currently on ARM64 platforms, we don't update the CPU topology masks
>> on each hotplug operation. However, the updates to cpu_coregroup_mask
> 
> I would add
> 
>     "leading to e.g. a system hang during system suspend."
> 
> to avoid people thinking this is purely a small bookkeeping issue without  any
> percussions.
> 

Sure, thanks. Sorry for missing that.

-- 
Regards,
Sudeep
