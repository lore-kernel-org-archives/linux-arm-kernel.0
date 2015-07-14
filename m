From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 14 Jul 2015 11:04:51 +0100
Subject: [RFC PATCH v2 1/1] drivers: cpuidle: cpuidle-arm: heterogeneous
 systems extension
In-Reply-To: <CAGS+omBtraNBH43qsFn_YgO3ePbFav9VtwgqDUinbOBMPwOGXA@mail.gmail.com>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1429200617-9546-2-git-send-email-lorenzo.pieralisi@arm.com>
 <554771D3.5010701@linaro.org> <20150505155615.GA23106@red-moon>
 <20150512130339.GB15131@red-moon>
 <CAGS+omBtraNBH43qsFn_YgO3ePbFav9VtwgqDUinbOBMPwOGXA@mail.gmail.com>
Message-ID: <20150714100451.GA16165@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Jul 14, 2015 at 05:52:48AM +0100, Daniel Kurtz wrote:

[...]

> > Any further comments ? I can post a v2 with an updated idle_states_cmp()
> > return value, if we think the multiple drivers approach is valid.
> 
> Can you post v2?
> From the silence on the list, I guess there is no strong objection to
> your approach.

I just wanted to make sure this patch is strictly required before asking
for a merge in the mainline, it adds to the code complexity so it should
not be taken lightly.

> So, perhaps it is time to remove the "RFC" as well so this can get on
> track to be merged.

I will drop the RFC status and add a simple configuration to define
a config entry to configure the max number of drivers statically so
that we do not waste memory for nothing.

Thanks,
Lorenzo
