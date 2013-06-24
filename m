From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jun 2013 13:10:35 -0700
Subject: [PATCH/RESEND 00/12] Convert MSM to common clock framework
In-Reply-To: <20130621012952.GE6300@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <20130621012952.GE6300@codeaurora.org>
Message-ID: <20130624201034.GA23147@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 06:29:52PM -0700, Stephen Boyd wrote:
>On 06/17, Stephen Boyd wrote:
>> Resending to collect higher level maintainer acks per Olof's request.
>> The plan is to push this patchset through MSM to the arm-soc tree.
>>
>> This patchset moves the existing MSM clock code and affected drivers to the
>> common clock framework. A prerequisite of moving to the common clock
>> framework is to use clk_prepare() and clk_enable() so the first
>> few patches migrate drivers to that call (clk_prepare() is a no-op on MSM
>> right now). It also removes some custom clock APIs that MSM provides
>> and finally moves the proc_comm clock code to the common struct clk.
>>
>> This patch series will be used as the foundation of the MSM 8660/8960
>> clock code that I plan to send out after this series.
>>
>
>David, can you pick this up and send it off to arm-soc now?

I'm still not seeing an Ack from

  msm_sdcc: Convert to clk_prepare/unprepare

Thanks,
David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
