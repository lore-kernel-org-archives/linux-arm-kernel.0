From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Thu, 01 Aug 2013 20:36:38 -0700
Subject: [RESEND PATCH 1/2] ARM: msm: Add support for MSM8974
In-Reply-To: <51FB1987.3060806@wwwdotorg.org>
References: <1375406619-14618-1-git-send-email-rvaswani@codeaurora.org>
 <51FB1987.3060806@wwwdotorg.org>
Message-ID: <51FB2946.2050503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/1/2013 7:29 PM, Stephen Warren wrote:
> On 08/01/2013 07:23 PM, Rohit Vaswani wrote:
>> This patch adds basic board support for MSM8974 which
>> belongs to the Snapdragon 800 family.
>> For now, just support a basic machine with device tree.
>>   arch/arm/boot/dts/msm8974.dts     | 26 ++++++++++++++++++++++++++
> That's odd. If this is support for an SoC, why not a *.dtsi file rather
> than *.dts?

I am not sure why I would need a dtsi if I am just adding the 1 file for 
the SoC support ?

Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
