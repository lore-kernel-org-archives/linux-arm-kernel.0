From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 18 Apr 2013 11:25:56 -0400
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <51701084.5050706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranavkumar,

On 04/18/2013 01:52 AM, PranavkumarSawargaonkar wrote:
> From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> 
> This patch implements early printk support for virtio-mmio console devices 
> without using any hypercalls.

Is it possible that using DCC might be an easier solution?

[...]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
