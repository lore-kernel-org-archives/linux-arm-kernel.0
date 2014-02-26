From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 26 Feb 2014 15:03:10 -0800
Subject: [PATCH 2/4] arm: qcom: Split Qualcomm support into legacy and
 multiplatform
In-Reply-To: <FF42247A-A4E8-4AA2-9C3B-BEEFC2F61714@codeaurora.org> (Kumar
 Gala's message of "Wed, 26 Feb 2014 11:22:47 -0600")
References: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
 <1391107002-21470-3-git-send-email-galak@codeaurora.org>
 <7hha7m0x9w.fsf@paris.lan>
 <FF42247A-A4E8-4AA2-9C3B-BEEFC2F61714@codeaurora.org>
Message-ID: <7hbnxtwk7l.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kumar Gala <galak@codeaurora.org> writes:

> On Feb 26, 2014, at 8:22 AM, Kevin Hilman <khilman@linaro.org> wrote:
>
>> Kumar Gala <galak@codeaurora.org> writes:
>> 
>>> Introduce a new mach-qcom that will support SoCs that intend to be
>>> multiplatform compatiable while keeping mach-msm to legacy SoC/board
>>> support that will not transition over to multiplatform.
>>> 
>>> As part of this, we move support for MSM8X60, MSM8960 and MSM8974 over
>>> to mach-qcom.
>>> 
>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> 
>> Having a closer look at this after seeing the multi_v7_defconfig change,
>> I have a minor nit on the new ARCH_QCOM name.
>> 
>> For new additions, we've been trying to move towards using SOC_foo
>> instead of ARCH_foo.  Any reason not to do that here also?
>> 
>> Kevin
>
> No reason, just wasn?t aware and no one said anything til now.  

Yeah, sorry for not reviewiing sooner.

> Hmm, how to handle this now, can we do this as a 3.16 cleanup?

Yes, we've already merged it, so doing it as a cleanup should be fine.

Thanks,

Kevin
