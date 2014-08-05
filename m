From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 5 Aug 2014 14:17:23 -0600 (MDT)
Subject: [PATCH 8/8] msm: scm: Move the scm driver to drivers/soc/qcom
In-Reply-To: <CAJAp7OiXW1A-H4io2kST_Y6LdVP+EYkXoU3GaWTRt_+CyXruQA@mail.gmail.com>
References: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
 <1407202310-3359-9-git-send-email-sboyd@codeaurora.org>
 <alpine.OSX.2.03.1408042203100.87047@linaro.org>
 <CAJAp7OiXW1A-H4io2kST_Y6LdVP+EYkXoU3GaWTRt_+CyXruQA@mail.gmail.com>
Message-ID: <alpine.OSX.2.03.1408051415360.89254@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




On Tue, 5 Aug 2014, Bjorn Andersson wrote:

> On Mon, Aug 4, 2014 at 9:07 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> > On Mon, 4 Aug 2014, Stephen Boyd wrote:
> [...]
> > Could we move scm-boot.c as well to drivers/soc/qcom and scm-boot.h to include/soc/qcom ?
> 
> Yes, we can do that.
> 
> But as of now we seem to only have one caller of this wrapper, so
> maybe we could move the functionality into platsmp.c and drop the file
> instead?
I am working on cpuidle drivers for QCOM targets and would very much
like the scm-boot to be accessible from drivers/soc/qcom.
