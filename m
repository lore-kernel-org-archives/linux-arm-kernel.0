From: sheetals@codeaurora.org (Sheetal Sahasrabudhe)
Date: Sat, 5 Mar 2011 13:18:50 -0800 (PST)
Subject: [PATCH 1/3] msm: Add support for Scorpion and ScorpionMP PMU
In-Reply-To: <4D71F7A0.5010101@codeaurora.org>
References: <1299276583-12542-1-git-send-email-sheetals@codeaurora.org>
	<4D71F7A0.5010101@codeaurora.org>
Message-ID: <abd1b409d545d4a3c24e4f0dedf56c6f.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trilok,

>> +static int __init scorpion_pmu_init(void)
>> +{
>> +	platform_device_register(&pmu_device);
>
> platform_device_register can fail. Better do it like
>
> "return platform_device_register(&pmu_device);

Good catch, I will update it.

Thanks,
Sheetal

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
