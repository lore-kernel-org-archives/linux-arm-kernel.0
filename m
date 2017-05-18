From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 18 May 2017 12:03:08 -0700
Subject: [PATCH 5/5] arm64: dts: qcom: Collapse usb support into one node
In-Reply-To: <20170127004728.22490-6-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
 <20170127004728.22490-6-stephen.boyd@linaro.org>
Message-ID: <20170518190308.GP12920@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 26 Jan 16:47 PST 2017, Stephen Boyd wrote:

> We currently have three device nodes for the same USB hardware
> block, as evident by the reuse of the same reg address multiple
> times. Now that the chipidea driver fully supports OTG with the
> MSM wrapper we can collapse all these nodes into one USB device
> node, reflecting the true nature of the hardware.
> 
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This still applies and with some defconfig updates seems to make USB
work again (thoroughly tested though). @Andy, would you mind picking
this up.

Regards,
Bjorn
