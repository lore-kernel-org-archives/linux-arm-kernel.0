From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 3 Jul 2018 09:54:12 +0200
Subject: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
In-Reply-To: <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
Message-ID: <CAJZ5v0hcBiYPMh8V50yq0jQud32Ey8V-ukiavJkP4PU4zAiFyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2018 at 7:44 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rafael,
>
> On 20 June 2018 at 19:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Changes in v8:
>>  - Added some tags for reviews and acks.
>>  - Cleanup timer patch (patch6) according to comments from Rafael.
>>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>>    improve the new function description a bit.
>>  - Corrected malformed SPDX-License-Identifier in patch20.
>
> There have only been a minor comment from you at patch3 (about
> squashing it with patch21), with that fixed and assuming there are no
> further comments - would you like me to collect the changes and send
> it to you as a pull request?

I have not looked at them in detail yet, sorry.

I any case, I'll apply the patches by hand.

Thanks,
Rafael
