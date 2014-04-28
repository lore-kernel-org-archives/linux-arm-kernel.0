From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 28 Apr 2014 08:30:38 -0400
Subject: [PATCH v8 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
References: <1398455329-18136-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398455329-18136-4-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>
 <CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
 <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
Message-ID: <CAJ5Y-ea50xLMDu63bcC2BFsu0_N1Zw09-9rOPrvHNF5xUq8dyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2014 08:23, Christoffer Dall <christoffer.dall@linaro.org> wrote:

>>
>> Whats the merge plan for these patches? We both share a common header
>> but the code that uses it would seemingly go up via different trees.
>> armv8 (Catalin) and KVM (Christoffer)?
>>
> Are they inter-dependent?  I thought your patches depended on Anup's -
> not the other way around?
>
> If my assumption is correct, I think we can make sure to send the pull
> request to kvm/next early and ask Catalin to pull in kvm/next before
> pulling your changes.


Right. My patches depend on the header (uapi/psci.h) introduced by
Anups patchset.

Cheers,
Ashwin
