From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 02 Aug 2014 04:34:41 +0200
Subject: [PATCH v6 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <1406940750-15880-1-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
Message-ID: <53DC4E41.4050200@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas

On 08/02/2014 02:52 AM, Andreas F?rber wrote:
> 
> Based on the preinstalled 3.8 based ChromeOS kernel and previous 3.15 
> based attempts by Stephan and me that broke for 3.16, I've prepared a 
> device tree for the HP Chromebook 11 aka Google Spring.
> 
> v6 renames a node and reverts dp_hpd.
> 
> Not yet enabled are trackpad, Wifi and sound.
> 
> My rebasing branch for testing is here:
> https://github.com/afaerber/linux/commits/spring-next
> 
> Regards,
> Andreas
> 

I made a comment on patch 05/10 but the rest of the series looks good to me. So
for the remaining patches:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

NOTE: I thought that Tomasz Figa gave you his Reviewed-by on v5 for the whole
series as well but I didn't see his tag on the v6 patches.

Best regards,
Javier
