From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 15 Mar 2012 15:19:43 -0700
Subject: [PATCH] Fixes after disintegration of asm/system.h for ARM
In-Reply-To: <20120315212619.31098.94700.stgit@warthog.procyon.org.uk>
References: <20120315212619.31098.94700.stgit@warthog.procyon.org.uk>
Message-ID: <4F626AFF.1060501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Howells:
> Signed-off-by: David Howells<dhowells@redhat.com>
> cc: Russell King<linux@arm.linux.org.uk>
> cc: linux-arm-kernel at lists.infradead.org
> ---

[...]

>   arch/arm/mach-s3c2410/s3c2410.c              |    1 +
>   arch/arm/mach-s3c2412/s3c2412.c              |    1 +
>   arch/arm/mach-s3c2416/s3c2416.c              |    1 +
>   arch/arm/mach-s3c2440/s3c244x.c              |    1 +
>   arch/arm/mach-s3c2443/s3c2443.c              |    1 +

Just note, above files have been moved into mach-s3c24xx/

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
