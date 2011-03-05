From: tsoni@codeaurora.org (Trilok Soni)
Date: Sat, 05 Mar 2011 14:13:12 +0530
Subject: [PATCH 1/3] msm: Add support for Scorpion and ScorpionMP PMU
In-Reply-To: <1299276583-12542-1-git-send-email-sheetals@codeaurora.org>
References: <1299276583-12542-1-git-send-email-sheetals@codeaurora.org>
Message-ID: <4D71F7A0.5010101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sheetal,

> +static int __init scorpion_pmu_init(void)
> +{
> +	platform_device_register(&pmu_device);

platform_device_register can fail. Better do it like

"return platform_device_register(&pmu_device);

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
