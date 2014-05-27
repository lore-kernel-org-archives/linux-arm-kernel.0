From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 27 May 2014 13:40:41 -0500
Subject: [PATCH 3/3] ARM: config: Update msm_defconfig
In-Reply-To: <20140527180504.GC26141@quad.lixom.net>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
 <1393467394-10907-4-git-send-email-sboyd@codeaurora.org>
 <20140227221458.GA5334@codeaurora.org>
 <318973D9-95B5-4D53-B774-D4239FD9AECB@codeaurora.org>
 <20140527180504.GC26141@quad.lixom.net>
Message-ID: <B2E10A66-097E-480F-9959-3F02B39CEAE2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 27, 2014, at 1:05 PM, Olof Johansson <olof@lixom.net> wrote:

> On Thu, Feb 27, 2014 at 06:22:37PM -0600, Kumar Gala wrote:
>> 
>> On Feb 27, 2014, at 4:14 PM, David Brown <davidb@codeaurora.org> wrote:
>> 
>>> On Wed, Feb 26, 2014 at 06:16:34PM -0800, Stephen Boyd wrote:
>>>> Now that DT based platforms are split out of mach-msm into
>>>> mach-qcom, put back a non-DT based SoC into the msm_defconfig and
>>>> stop selecting unsupported drivers.
>>>> 
>>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>>> ---
>>>> arch/arm/configs/msm_defconfig | 25 +++----------------------
>>>> 1 file changed, 3 insertions(+), 22 deletions(-)
>>> 
>>> Acked-by: David Brown <davidb@codeaurora.org>
>>> 
>>> Kumar, can you just pull this in with the other qcom changes from
>>> Sephen?
>> 
>> sure
> 
> I didn't see 2/3 land in our tree through branches from you. Should I
> just apply it directly by now?
> 
> 
> -Olof

please do.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
