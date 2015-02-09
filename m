From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 9 Feb 2015 20:02:21 +0100 (CET)
Subject: [PATCH v3 04/20] power_supply: sysfs: Use power_supply_*() API
 for accessing function attrs
In-Reply-To: <1422629278-12202-5-git-send-email-k.kozlowski@samsung.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <70066540.345820.1423508541546.JavaMail.open-xchange@oxbaltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

> Krzysztof Kozlowski <k.kozlowski@samsung.com> hat am 30. Januar 2015 um 15:47
> geschrieben:
>
>
> Replace direct calls to power supply function attributes with wrappers.
> Wrappers provide safe access in case of unregistering the power
> supply (e.g. by removing the driver). Replace:
> - get_property -> power_supply_get_property
> - set_property -> power_supply_set_property
> - property_is_writeable -> power_supply_property_is_writeable
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>

just a nit. It looks like a typo in the mail address which is also in patch 5 -
10.

I applied patch 1 - 14 to my repo with a upcoming power driver (mxs_power) and
didn't see any problems with your patches.

Stefan

> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> ---
