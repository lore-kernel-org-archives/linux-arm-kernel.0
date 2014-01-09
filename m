From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 Jan 2014 10:40:31 -0800
Subject: [PATCH v2 6/7] drm/msm: Drop unnecessary mach include
In-Reply-To: <20140109081352.GI8285@quad.lixom.net>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <1388438133-431-7-git-send-email-sboyd@codeaurora.org>
 <CAF6AEGtortD9FQP-vDj7apsmdkXcoOiahJf++zPcSh=OYg7WfA@mail.gmail.com>
 <CAF6AEGt7o65zpPPJa1chvYdp+K-dkSH9Buq=rDxyrUyS0zh3eA@mail.gmail.com>
 <20131231051558.GB14405@codeaurora.org>
 <20140109081352.GI8285@quad.lixom.net>
Message-ID: <52CEED1F.3030906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/14 00:13, Olof Johansson wrote:
> On Mon, Dec 30, 2013 at 09:15:58PM -0800, Stephen Boyd wrote:
>> On 12/30, Rob Clark wrote:
>>> On Mon, Dec 30, 2013 at 8:12 PM, Rob Clark <robdclark@gmail.com> wrote:
>>>> On Mon, Dec 30, 2013 at 4:15 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>>>> This file doesn't use the clk_reset() API that is exposed in
>>>>> mach-msm's mach/clk.h file. Remove the include so that this
>>>>> driver can be compiled as part of the multi-platform kernel.
>>>> Thanks!
>>>>
>>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> I think you mean Acked-by? Signed-off-by usually means you're
>> sending the patch along.
> I've held off applying this, but I have applied the others -- please
> merge this through the DRM tree since it will need to go on top of
> changes there.
>
> That also means that enabling the MSM DTM driver in a multiplatform
> kernel will cause build breakages until the equivalent patch has been
> picked up. Since it's not enabled by any defconfigs I'm not too worried,
> but it will show up on randconfigs.
>

Ok. I think Rob's still planning to send his patch through the DRM tree
so we should be ok on the other end of the merge window.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
