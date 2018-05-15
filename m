From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 15 May 2018 10:00:57 +0200
Subject: [PATCH 0/2] Revert explicit support for Renesas R-Car Gen 3
 r8a779[56] SoCs
In-Reply-To: <20180515073553.372uzwx4gvj5qpk4@verge.net.au>
References: <20180502095806.30341-1-horms+renesas@verge.net.au>
 <2473510.IAjYrYimeR@aspire.rjw.lan>
 <20180515073553.372uzwx4gvj5qpk4@verge.net.au>
Message-ID: <CAJZ5v0hyga1pHCqJK5e5y1fXJLLc3cDm1p7N2o6bzPZFNpRZxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 9:35 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 10, 2018 at 11:51:38AM +0200, Rafael J. Wysocki wrote:
>> On Wednesday, May 2, 2018 11:58:04 AM CEST Simon Horman wrote:
>> > Revert commits that added explicit support for Renesas R-Car Gen 3
>> > r8a779[56] SoCs to the generic cpufreq driver.
>> >
>> > This is no longer needed since the flowing commit and to the best of my
>> > knowledge is not relied on by any upstream DTS: edeec420de24 ("cpufreq:
>> > dt-platdev: Automatically create cpufreq device with OPP v2")
>> >
>> > Simon Horman (2):
>> >   Revert "cpufreq: dt: Add r8a7796 support to to use generic cpufreq
>> >     driver"
>> >   Revert "cpufreq: rcar: Add support for R8A7795 SoC"
>> >
>> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> >
>>
>> Am I expected to pick up this series?
>
> Hi Rafael,
>
> that would be ideal from my point of view.

OK, I'll queue them up, then.

Thanks!
