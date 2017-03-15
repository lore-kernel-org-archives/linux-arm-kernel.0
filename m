From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Mar 2017 05:33:51 -0500
Subject: [PATCH] pinctrl: qcom: qdf2xxx: add names to the gpios
In-Reply-To: <CACRpkdZE2kawSKaukwbdDHPKfzeAvMCMe8ZTGWB8FvPqObruDQ@mail.gmail.com>
References: <1488843122-7960-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZE2kawSKaukwbdDHPKfzeAvMCMe8ZTGWB8FvPqObruDQ@mail.gmail.com>
Message-ID: <5f2fa494-5dc2-1186-f516-c3a5dfb65b98@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> Patch tentatively applied (looks right to me), unless Bj?rn has concerns.
>
> Is this a problem in other qcom pinctrl drivers?

Not any of the ones that use pinctrl-msm, because they all use the static 
arrays, whereas my driver (because it's for ACPI), creates a dynamic array.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
