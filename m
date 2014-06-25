From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 11:44:47 +0200
Subject: [PATCH v14 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <20140625044845.GK5918@pengutronix.de>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-4-git-send-email-denis@eukrea.com>
 <20140625044845.GK5918@pengutronix.de>
Message-ID: <53AA9A0F.605@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 06:48 AM, Sascha Hauer wrote:
>> +#define ENABLE_POL_LOW		0
>> +#define ENABLE_POL_HIGH		1
>
> Adding defines without a proper namespace (IPU_) outside a driver
> private header file is not nice. Anyway, instead of adding the
> defines ...
Fixed in "imx-drm: use defines for clock polarity settings" and in 
"imx-drm: Use drm_display_mode timings flags.".

Denis.
