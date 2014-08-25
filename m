From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 25 Aug 2014 13:54:07 +0200
Subject: [PATCH v2 1/1] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <53FB22E4.8040906@suse.de>
References: <1408956336-17376-1-git-send-email-javier.martinez@collabora.co.uk>
 <5825205.70RuHaSG5p@amdc1032> <53FB22E4.8040906@suse.de>
Message-ID: <53FB23DF.70809@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 08/25/2014 01:49 PM, Andreas F?rber wrote:
>> 
>> Could you please also do corresponding update to multi_v7_defconfig?
> 
> As was mentioned in v1 (but now below), some of these options depend on

Sorry for missing the mention about the dependencies on v2...

> patches yet to be respun and be accepted into drm, so I would consider
> this an RFC patch and suggest to wait with multi_v7.
> 

Agreed, I just sent an email to Bartlomiej saying the same.

> It could of course be split, as CONFIG_DRM_EXYNOS* and backlight parts
> are certainly okay.
>

Also agreed.

> Regards,
> Andreas

Best regards,
Javier
