From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 16 May 2017 15:37:25 +0530
Subject: [PATCH v5 1/3] phy: qcom-usb: Remove unused ulpi phy header
In-Reply-To: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <02e495ea-5e21-d8bf-c869-d62ed5b70770@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Thursday 11 May 2017 12:17 PM, Vivek Gautam wrote:
> Ulpi phy header is not used for anything. Remove the same
> from qcom-hs and qcom-hsic phy drivers.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-usb at vger.kernel.org

this patch introduced a bunch of compiler errors because of missing "#include
<linux/phy/phy.h>". I fixed it and merged to linux-phy fixes.

Thanks
Kishon
