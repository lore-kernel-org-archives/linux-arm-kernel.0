From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 4 May 2017 10:41:54 -0500
Subject: [PATCH] MAINTAINERS: add arm@kernel.org as the list for arm64
 defconfig changes
In-Reply-To: <0ad7d305-d323-339f-9534-d559f1cf656a@codeaurora.org>
References: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
 <20170503170110.GB23620@e104818-lin.cambridge.arm.com>
 <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
 <CAOesGMiY9o8199bb13gsd3SAs8YR-4rafYHoyV3VmK0dY0MDtQ@mail.gmail.com>
 <4b048ba1-b7e4-6ab6-95be-3163120f63aa@codeaurora.org>
 <CAOesGMgnOQXtLT8aUvPhXDfShzhkP-3LWFhP60xiMn65x6aq=w@mail.gmail.com>
 <0ad7d305-d323-339f-9534-d559f1cf656a@codeaurora.org>
Message-ID: <20170504154154.GA13706@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 12:47:16PM -0500, Timur Tabi wrote:
> On 05/03/2017 12:39 PM, Olof Johansson wrote:
> > No, I'm not saying that, and there is a better way: Send it through
> > Andy if in doubt -- it should be his job as your platform maintainer
> > to help guide you through the system if needed.
> 
> Will told me that defconfig patches should go to arm at kernel.org, but you're
> telling me they should go to Andy instead.
> 
> Andy's being the platform maintainer is news to me.  I'm not saying he
> isn't, but I can't remember the last time I involved him in any patches of ours.

If it is Qualcomm related, it generally goes through me.  And I send it up
through the arm soc guys (kevin, olof, and arnd).

> 
> Either way, I think there should be a designated maintainer for
> arch/arm64/configs/defconfig, and I think that person/alias should be in
> MAINTAINERS.

I disagree here.  We've generally had defconfigs go up through the disparate ARM
board maintainers and they get collated by arm-soc.  It's easy when it's
something like qcom_defconfig, but get_maintainer doesn't give you the correct
name if you are going for multiv7 or some of the default configs.


Andy
