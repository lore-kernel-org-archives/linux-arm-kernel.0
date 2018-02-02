From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 20:29:24 +0530
Subject: [PATCH v6 27/41] ARM: da8xx: add new sata_refclk init using
 common clock framework
In-Reply-To: <1516468460-4908-28-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-28-git-send-email-david@lechnology.com>
Message-ID: <8bb4fff4-df9b-f940-0dbe-888942f55abf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> This adds the new SATA REFCLK clock init in mach-davinci/devices-da8xx.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also, the #includes are sorted since we are adding some here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
