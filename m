From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 26 Feb 2014 06:22:03 -0800
Subject: [PATCH 2/4] arm: qcom: Split Qualcomm support into legacy and
 multiplatform
In-Reply-To: <1391107002-21470-3-git-send-email-galak@codeaurora.org> (Kumar
 Gala's message of "Thu, 30 Jan 2014 12:36:40 -0600")
References: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
 <1391107002-21470-3-git-send-email-galak@codeaurora.org>
Message-ID: <7hha7m0x9w.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kumar Gala <galak@codeaurora.org> writes:

> Introduce a new mach-qcom that will support SoCs that intend to be
> multiplatform compatiable while keeping mach-msm to legacy SoC/board
> support that will not transition over to multiplatform.
>
> As part of this, we move support for MSM8X60, MSM8960 and MSM8974 over
> to mach-qcom.
>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Having a closer look at this after seeing the multi_v7_defconfig change,
I have a minor nit on the new ARCH_QCOM name.

For new additions, we've been trying to move towards using SOC_foo
instead of ARCH_foo.  Any reason not to do that here also?

Kevin
