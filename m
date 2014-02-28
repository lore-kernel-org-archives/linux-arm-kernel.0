From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 27 Feb 2014 18:22:37 -0600
Subject: [PATCH 3/3] ARM: config: Update msm_defconfig
In-Reply-To: <20140227221458.GA5334@codeaurora.org>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
 <1393467394-10907-4-git-send-email-sboyd@codeaurora.org>
 <20140227221458.GA5334@codeaurora.org>
Message-ID: <318973D9-95B5-4D53-B774-D4239FD9AECB@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 27, 2014, at 4:14 PM, David Brown <davidb@codeaurora.org> wrote:

> On Wed, Feb 26, 2014 at 06:16:34PM -0800, Stephen Boyd wrote:
>> Now that DT based platforms are split out of mach-msm into
>> mach-qcom, put back a non-DT based SoC into the msm_defconfig and
>> stop selecting unsupported drivers.
>> 
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>> arch/arm/configs/msm_defconfig | 25 +++----------------------
>> 1 file changed, 3 insertions(+), 22 deletions(-)
> 
> Acked-by: David Brown <davidb@codeaurora.org>
> 
> Kumar, can you just pull this in with the other qcom changes from
> Sephen?

sure

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
