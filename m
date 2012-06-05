From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 05 Jun 2012 11:47:51 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <20120604101447.GF8262@n2100.arm.linux.org.uk>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120604101447.GF8262@n2100.arm.linux.org.uk>
Message-ID: <4FCDE3D7.9030006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/12 11:14, Russell King - ARM Linux wrote:
> So why is this buggy patch now merged in the mainline kernel?

I guess Chris took it because you said it was fine?

On 03/05/12 17:30, Russell King - ARM Linux wrote:
> On Thu, May 03, 2012 at 04:30:48PM +0100, Lee Jones wrote:
>> From: Lee Jones<lee.jones@linaro.org>
>> Date: Mon, 16 Apr 2012 10:18:43 +0100
>> Subject: [PATCH 01/19] MMC: mmci: Enable Device Tree support for ux500
>>   variants
>>
>> Provide a means to collect attributes specific to ST-Ericsson's
>> ux500 variant series. This patch registers itself as the AMBA
>> driver to be called during the probe process. Once all
>> attributes and ux500 specifics are are collected the normal
>> mmci core probe is called.
>>
>> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>> Acked-by: Arnd Bergmann<arnd@arndb.de>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> 
> This looks fine now, thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
