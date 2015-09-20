From: agross@codeaurora.org (Andy Gross)
Date: Sat, 19 Sep 2015 21:52:18 -0500
Subject: [PATCH 00/14] ARM: dts: apq8064 dt cleanups and additions
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150920025218.GA24949@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 01:29:31PM +0100, Srinivas Kandagatla wrote:
> Hi Andy, 
> 
> Here are few cleanup and additions to the existing APQ8064 device tree.
> 
> Some of the patches are to do with princtrl cleanup which was always not
> in the right place and some of the pinctrls were missing.
> Other set of patches is to do with adding more devices like rtc rng
> and pwr key for pmic 8921.
> Last set of patches are related to pwrseq and SD card detect taking Stephens
> comments into consideration.

These all look fine.  I tested in ifc6410 as well.  I'll test on qs600 to be
sure.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
