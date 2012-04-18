From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 18 Apr 2012 13:46:58 +0530
Subject: [PATCH v4 2/2] regulator: add device tree support for max8997
In-Reply-To: <20120417183829.GW6652@opensource.wolfsonmicro.com>
References: <1332582590-16382-1-git-send-email-thomas.abraham@linaro.org>
 <1332582590-16382-3-git-send-email-thomas.abraham@linaro.org>
 <4F734460.4060605@samsung.com>
 <CAJuYYwRsHynt6pBHUgk72Z-UjHj3DM=s4pV4dzbb2hTAZOUSAw@mail.gmail.com>
 <20120417183829.GW6652@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwSg-VkWe=0PFNj2snX4+_fN7Lc1-YU1xdUvTM9uJvha7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 18 April 2012 00:08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Apr 18, 2012 at 12:05:59AM +0530, Thomas Abraham wrote:
>> On 28 March 2012 22:33, Karol Lewandowski <k.lewandowsk@samsung.com> wrote:
>
>> >> + ? ?For BUCK's:
>
> No 's here, BTW.

Ok.

>
>> > ?- EN32KHz_AP
>> > ?- EN32KHz_CP
>> > ?- ENVICHG
>> > ?- ESAFEOUT1
>> > ?- ESAFEOUT2
>> > ?- CHARGER
>> > ?- CHARGER_CV
>> > ?- CHARGER_TOPOFF
>
>> > I wonder if these should be mentioned in documentation too.
>
>> Yes, I missed the above regulators in the documentation. I have
>> included them now and will resubmit this patch.
>
> Please omit the clocks; these are obviously a bodge due to the inability
> to support clocks off-SoC so we shouldn't be enshrining them in the
> device tree bindings.

Thanks for the suggestion. I have removed EN32KHz_AP and EN32KHz_CP
from the list. The rest are either voltage (fixed) or current
regulators.

Regards,
Thomas.
