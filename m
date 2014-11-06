From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 06 Nov 2014 21:17:30 +0100
Subject: [RESEND PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in
 GPMC driver
In-Reply-To: <20141106185235.GD31454@atomide.com>
References: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
 <1395209295-24399-3-git-send-email-javier.martinez@collabora.co.uk>
 <20141106185235.GD31454@atomide.com>
Message-ID: <545BD75A.5040708@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

On 11/06/2014 07:52 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [140318 23:12]:
>> The GPMC driver includes arch/arm/mach-omap2/common.h but
>> does not use anything on that header so it can be removed.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Probably meant Cc here? :) I'll apply this into omap-for-v3.19/gpmc,
> the rest will need to wait until omap3 is DT only.
> 

Ups, I don't know how your s-o-b ended there :)

Thanks a lot for picking such an old patch.

Best regards,
Javier
