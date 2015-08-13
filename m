From: agross@codeaurora.org (Andy Gross)
Date: Thu, 13 Aug 2015 10:31:05 -0500
Subject: [GIT PULL] qcom SoC changes for 4.3 *CORRECTED*
In-Reply-To: <20150813130818.GE23581@localhost>
References: <1438379275-6314-1-git-send-email-agross@codeaurora.org>
 <20150813130818.GE23581@localhost>
Message-ID: <20150813153105.GB4627@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 03:08:18PM +0200, Olof Johansson wrote:
> On Fri, Jul 31, 2015 at 04:47:55PM -0500, Andy Gross wrote:
> > The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> > 
> >   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-soc-for-4.3
> > 
> > for you to fetch changes up to ba68227e610cec8e0bef7da7e04af3f479d9797d:
> > 
> >   devicetree: soc: Add Qualcomm SMD based RPM DT binding (2015-07-29 14:13:48 -0500)
> > 
> > ----------------------------------------------------------------
> > Qualcomm ARM Based SoC Updates for 4.3
> > 
> > * Add SMEM driver
> > * Add SMD driver
> > * Add RPM over SMD driver
> > * Select QCOM_SCM by default
> > 
> > ----------------------------------------------------------------
> > Bjorn Andersson (5):
> >       soc: qcom: Add Shared Memory Manager driver
> >       soc: qcom: Add device tree binding for Shared Memory Device
> >       soc: qcom: Add Shared Memory Driver
> >       soc: qcom: Driver for the Qualcomm RPM over SMD
> >       devicetree: soc: Add Qualcomm SMD based RPM DT binding
> > 
> > Lina Iyer (1):
> >       drivers: qcom: Select QCOM_SCM unconditionally for QCOM_PM
> 
> Ok, after looking through it, I've decided to merge this branch.
> 
> I'm still concerned that we are picking up similar functionality without
> any shared implementation for a lot of platforms right now. At some
> point we'll have to say that enough is enough and someone will have to
> clean it up.
> 
> In the past, Linaro has done some of that work since several members have been
> affected. I don't know if this is the right time to kick something off though,
> or if we should let a few more implementations surface such that there is
> a better set of needed use cases to base a common framework on.

We can certainly discuss this at the coming Connect.  I'll bring this up then.

Thanks for pulling this in.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
