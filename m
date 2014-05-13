From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 13 May 2014 12:45:43 +0900
Subject: [PATCH 1/2] ARM: tegra: joystick input in tegra_defconfig
In-Reply-To: <5370F794.2020800@wwwdotorg.org>
References: <1399883209-31169-1-git-send-email-acourbot@nvidia.com>
 <1399883209-31169-2-git-send-email-acourbot@nvidia.com>
 <5370F794.2020800@wwwdotorg.org>
Message-ID: <CAAVeFuLZ_wrxipYn2pfNzuyDiTvAPWH4aSWfonrG+YQsm4tM_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 1:32 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/12/2014 02:26 AM, Alexandre Courbot wrote:
>> NVIDIA SHIELD embeds a USB controller. Compile the corresponding support
>
> USB controller or USB joystick?

I understand this sounds like "EHCI controller" here. Will reword.

>
>> as a module in tegra_defconfig.
>
> Why make this a module rather than built-in. Almost everything else in
> tegra_defconfig is built-in, except brcmfmac since it doesn't handle
> lack of firmware availability at probe time.

Goal is to minimize the image size, especially since this is not a
feature I expect to be used much outside of SHIELD. If you prefer it
built-in, I'm fine with it too.

Thanks,
Alex.
