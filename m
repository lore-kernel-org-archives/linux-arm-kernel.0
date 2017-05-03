From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 May 2017 12:47:16 -0500
Subject: [PATCH] MAINTAINERS: add arm@kernel.org as the list for arm64
 defconfig changes
In-Reply-To: <CAOesGMgnOQXtLT8aUvPhXDfShzhkP-3LWFhP60xiMn65x6aq=w@mail.gmail.com>
References: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
 <20170503170110.GB23620@e104818-lin.cambridge.arm.com>
 <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
 <CAOesGMiY9o8199bb13gsd3SAs8YR-4rafYHoyV3VmK0dY0MDtQ@mail.gmail.com>
 <4b048ba1-b7e4-6ab6-95be-3163120f63aa@codeaurora.org>
 <CAOesGMgnOQXtLT8aUvPhXDfShzhkP-3LWFhP60xiMn65x6aq=w@mail.gmail.com>
Message-ID: <0ad7d305-d323-339f-9534-d559f1cf656a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2017 12:39 PM, Olof Johansson wrote:
> No, I'm not saying that, and there is a better way: Send it through
> Andy if in doubt -- it should be his job as your platform maintainer
> to help guide you through the system if needed.

Will told me that defconfig patches should go to arm at kernel.org, but you're
telling me they should go to Andy instead.

Andy's being the platform maintainer is news to me.  I'm not saying he
isn't, but I can't remember the last time I involved him in any patches of ours.

Either way, I think there should be a designated maintainer for
arch/arm64/configs/defconfig, and I think that person/alias should be in
MAINTAINERS.

> Sometimes we tweak defconfigs late in the merge window and sometimes
> even during early -rc, so let us get back to this after we've handled
> the merges.

Ok, thank you.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
