From: skannan@codeaurora.org (skannan at codeaurora.org)
Date: Mon, 24 Feb 2014 08:47:15 -0000
Subject: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
In-Reply-To: <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
 <530AF7E4.5080806@linux.vnet.ibm.com>
 <CAKohpok-8_JV8hRDiWnRLYqEqyvD60cyn5Hs1HcZTSEPZjLvOQ@mail.gmail.com>
 <a7536f7b5a03fe287aaf1974db74ba64.squirrel@www.codeaurora.org>
 <CAKohpomRqboKjHRF8ev9erJ6MdRWcsX2jO7A=g47gMmewm_ZiQ@mail.gmail.com>
Message-ID: <b59f4a49af4ebd12c2d61e58dfb27a39.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Viresh Kumar wrote:
> On 24 February 2014 14:11,  <skannan@codeaurora.org> wrote:
>> I just replied to the other email. I think I answered both your
>> questions
>> there. Sorry about mixing up CPU and policy. In my case, each CPU is
>> independently scalable -- so for now take CPU == policy. I'll fix it up
>> once we agree on the fix.
>
> But why do you say this then?

Sorry, not sure I understand what you mean.

I agree, wording in my commit text might be unclear. I'll fix it after we
agree on the code fix. In the MSM case, each CPU has it's own policy.

I'm assuming your original complaint was about my confusing wording. Maybe
that's not what you were pointing out?

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
