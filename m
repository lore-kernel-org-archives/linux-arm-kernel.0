From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 20:07:49 +0530
Subject: [PATCH v6 23/41] ARM: dm365: add new clock init using common
 clock framework
In-Reply-To: <1516468460-4908-24-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-24-git-send-email-david@lechnology.com>
Message-ID: <1550e88d-9f89-3185-7da4-0cf5ebb7475a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/dm365.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
