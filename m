From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jun 2014 21:56:31 +0100
Subject: [PATCH v14 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <53AA9A0F.605@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-4-git-send-email-denis@eukrea.com>
 <20140625044845.GK5918@pengutronix.de> <53AA9A0F.605@eukrea.com>
Message-ID: <20140626205631.GB32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 11:44:47AM +0200, Denis Carikli wrote:
> On 06/25/2014 06:48 AM, Sascha Hauer wrote:
>>> +#define ENABLE_POL_LOW		0
>>> +#define ENABLE_POL_HIGH		1
>>
>> Adding defines without a proper namespace (IPU_) outside a driver
>> private header file is not nice. Anyway, instead of adding the
>> defines ...
> Fixed in "imx-drm: use defines for clock polarity settings" and in  
> "imx-drm: Use drm_display_mode timings flags.".

Denis, can you send just this one updated patch, so I can update the
one I have here with this change.  Once you've done that, I'll send
the first four off to Greg.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
