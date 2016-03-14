From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Mar 2016 09:46:12 +0000
Subject: [GIT PULL] ARM: dts: vexpress: fixes for v4.6
In-Reply-To: <20160313012756.GB5883@localhost>
References: <56DF027E.3070807@arm.com> <20160313012756.GB5883@localhost>
Message-ID: <56E68864.7020206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/03/16 01:27, Olof Johansson wrote:
> On Tue, Mar 08, 2016 at 04:49:02PM +0000, Sudeep Holla wrote:

[...]

>> Update for ARM VExpress platforms
>>
>> Just one update to fix node name unit-address presence/absence mismatch
>> warnings in all the Vexpress device trees.
>
> These kidn of changes can really wait until the next cycle when they
> come in this late; there's already discussion on whether the dtc uprev
> was the right thing to do or not at this time.
>

Ah OK, I was not sure if that will be dropped, hence sent this change.

> So, I'll hold off on this one since there's no other material in this branch.

Sure, I will post this after v4.6 merge window.

-- 
Regards,
Sudeep
