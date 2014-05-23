From: chris@printf.net (Chris Ball)
Date: Fri, 23 May 2014 13:52:42 +0100
Subject: [PATCH v3 1/2] mmc: tegra: disable UHS modes
In-Reply-To: <CAPDyKFpt98rbFpvu1uzbOuhCTrO96hzQU2VwNRgJGfoi_7F-OA@mail.gmail.com>
 (Ulf Hansson's message of "Fri, 23 May 2014 09:03:33 +0200")
References: <1400774136-12396-1-git-send-email-abrestic@chromium.org>
 <CAPDyKFpt98rbFpvu1uzbOuhCTrO96hzQU2VwNRgJGfoi_7F-OA@mail.gmail.com>
Message-ID: <86fvk0r71h.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 23 2014, Ulf Hansson wrote:
> On 22 May 2014 17:55, Andrew Bresticker <abrestic@chromium.org> wrote:
>> Program TEGRA_SDHCI_VENDOR_MISC_CTRL so that UHS modes aren't advertised
>> in SDHCI_CAPABILITIES_1.  While the Tegra SDHCI controller does support
>> these modes, they require Tegra-specific tuning and calibration routines
>> which the driver does not support yet.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> Thanks Andrew!
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Chris, can you pick this up?

Thanks, pushed to mmc-next for 3.16.

- Chris.
-- 
Chris Ball   <http://printf.net/>
