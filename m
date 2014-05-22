From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 22 May 2014 13:00:50 +0200
Subject: [PATCH v2 1/3] mmc: tegra: disable UHS modes
In-Reply-To: <86egzormf5.fsf@void.printf.net>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-2-git-send-email-abrestic@chromium.org>
 <537B9022.20709@wwwdotorg.org> <86egzormf5.fsf@void.printf.net>
Message-ID: <CAPDyKFqq-kjQoMiyKApDuTR+Fc-8WOuqXHFcgwgZNkg4Mm4Z=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2014 02:43, Chris Ball <chris@printf.net> wrote:
> Hi Stephen,
>
> On Tue, May 20 2014, Stephen Warren wrote:
>> On 04/16/2014 05:08 PM, Andrew Bresticker wrote:
>>> Program TEGRA_SDHCI_VENDOR_MISC_CTRL so that UHS modes aren't advertised
>>> in SDHCI_CAPABILITIES_1.  While the Tegra SDHCI controller does support
>>> these modes, they require Tegra-specific tuning and calibration routines
>>> which the driver does not support yet.
>>
>> What's the status of patches 1 and 2 in this series? I assumed they'd be
>> applied to the MMC tree. I've had them applied to my local development
>> tree for a while now, so in case this helps:
>>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>>
>> (I thought I wrote that before, but I can't find it, so I must have
>> forgotten to)
>
> We've been waiting for a very large sdhci patchset from Russell to
> land before merging other sdhci patches, but I think we're running
> out of time for that -- so we'll merge this one way or another within
> a few days.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <http://printf.net/>


Hi Stephen/Andrew,

I tried to include the v2 of patch1 and patch2 in PR I just sent to
Chris - but needed to omit them due to conflicts.

Could you please re-base them on top of my PR and resend them? I
suppose Chris can take them separately once he pulled my PR.

Kind regards
Ulf Hansson
