From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Feb 2014 14:13:15 -0800
Subject: [PATCH] ARM: dts: qcom: Add RNG device tree node
In-Reply-To: <52FB3EB5.4020207@mm-sol.com>
References: <1391764987-17138-1-git-send-email-svarbanov@mm-sol.com>
 <20140208033740.GD10784@codeaurora.org>
 <52FB3EB5.4020207@mm-sol.com>
Message-ID: <20140218221315.GC14769@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12, Stanimir Varbanov wrote:
> Hi, Stephen
> 
> On 02/08/2014 05:37 AM, Stephen Boyd wrote:
> > On 02/07, Stanimir Varbanov wrote:
> >> Add the necessary DT node to probe the rng driver on
> >> msm8974 platforms.
> >>
> > 
> > Looks good. We should add it to msm8960-cdp and enable the driver
> > in the defconfig as well.
> 
> Sure, I can prepare a patch. Unfortunately I haven't msm8960 CDP to test it.
> 

No problem. I have one on my desk and can run a test if you like.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
