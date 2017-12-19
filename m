From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 19 Dec 2017 14:32:28 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <20171219203055.GF7997@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <1f6b198f-d277-51dd-09ad-e1d751d5c1fa@codeaurora.org>
 <20171219203055.GF7997@codeaurora.org>
Message-ID: <dca53d8f-ebdb-bce5-41d7-e27c0713bb5e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2017 02:30 PM, Stephen Boyd wrote:
> Yeah I wouldn't do that. I'm not trying to avoid allocating the
> array anymore. Dynamically sized arrays on the stack are not a
> great idea in the kernel where we have limited stack sizes.

So do you just want to see a v11 that drops support for QCOM8001?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
