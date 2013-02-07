From: davidb@codeaurora.org (David Brown)
Date: Thu, 07 Feb 2013 11:05:01 -0800
Subject: [PATCH 09/10] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <5113e62e.c84e420a.08c3.ffffbf14@mx.google.com> (manjunath
 goudar's message of "Thu, 7 Feb 2013 23:04:06 +0530")
References: <5113e62e.c84e420a.08c3.ffffbf14@mx.google.com>
Message-ID: <8yaa9rglzc2.fsf@huya.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

manjunath.goudar at linaro.org writes:

> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_ALIAS("platform:omap-msm");
> +MODULE_LICENSE("GPL");

omap-msm?  I think you mean msm-ehci.

I don't have any hardware to test this on, so hopefully someone can
chime in after testing it.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
