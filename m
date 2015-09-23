From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 11:42:25 -0500
Subject: master build: 1 failures 68 warnings (v4.3-rc2-16-gac2fc4b)
In-Reply-To: <20150922161832.GH30445@sirena.org.uk>
References: <E1ZeICY-00014h-E8@optimist> <20150922161832.GH30445@sirena.org.uk>
Message-ID: <20150923164225.GA14209@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 09:18:32AM -0700, Mark Brown wrote:
> On Tue, Sep 22, 2015 at 08:41:25AM +0100, Build bot for Mark Brown wrote:
> 
> Mainline is still failing to build an arm64 allmodconfig due to:
> 
> > 	arm64-allmodconfig
> > ../drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before '__asmeq'
> > ../drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function 'secure_flush_area' [-Werror=implicit-function-declaration]
> > ../drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function 'outer_inv_range' [-Werror=implicit-function-declaration]
> > ../drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before '__asmeq'
> > ../drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before '__asmeq'
> 
> which has been the case since before -rc1.  There was a patch posted for
> this by Andy Gross (firmware: qcom: scm: Add function stubs for ARM64)
> which got positively reviewed - where are we with getting that merged
> into mainline?

V2 of the patch is out and reviewed by Russell and Bjorn.  I have it in next
right now.  I'll resend my pull shortly.


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
