From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:45:33 +0530
Subject: [PATCH v3 14/15] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <1359445870-18925-15-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-15-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B5D85.9050206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
>
> Add the required code to properly handle race free platform coherency exit
> to the DCSCB power down method.
>
> The power_up_setup callback is used to enable the CCI interface for
> the cluster being brought up.  This must be done in assembly before
> the kernel environment is entered.
>
> Thanks to Achin Gupta and Nicolas Pitre for their help and
> contributions.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
My concerns on this patch are already highlighted by Lorenzo.
Apart from that patch looks fine to me.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
