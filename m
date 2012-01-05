From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 5 Jan 2012 22:13:32 +0530
Subject: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <4F05CE60.5090402@samsung.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
 <20111107211726.GC28491@ponder.secretlab.ca>
 <CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
 <4F047235.2090503@samsung.com>
 <CAJuYYwTMpde-528t=vQnbkJv_gG7xuOr05b1K-+H-RxYRX0iEQ@mail.gmail.com>
 <4F05CE60.5090402@samsung.com>
Message-ID: <CAJuYYwRiubBo5Y4K_x_VPeRWOzmHgegyV4Sh=Eee6JgfAmP2iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 5 January 2012 21:52, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
[...]

>> Sorry for the delaying in completing this patchset. I will redo this
>> patchset and submit it soon. But 3.3-rc1 looks unlikely.
>
> Ok, thanks. It's fine, there is no rush. I was just curious because we have
> reused this sdhci driver update series and it seemed essential for initial
> DT support on Exynos4 machines. Just FYI I have prepared initial DT support
> patches for the S5P MIPI-CSI2 (s5p-mipi-csis) receiver driver.
> But the whole camera subsystem needs more work, i.e. resource dependencies
> (clock) between all involved devices (like image sensors and video capture
> platform devices) need to be resolved and method of registering sub-devices
> in the V4L2 core will likely need to be changed.

Thanks for the information. It was helpful to know that you are working on this.

Regards,
Thomas.

>
>
> --
> Thanks,
> Sylwester
