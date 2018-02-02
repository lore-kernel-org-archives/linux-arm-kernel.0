From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 20:09:37 +0530
Subject: [PATCH v6 24/41] ARM: dm644x: add new clock init using common
 clock framework
In-Reply-To: <1516468460-4908-25-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-25-git-send-email-david@lechnology.com>
Message-ID: <28508a72-2fc7-1dc2-8a2c-997139d70831@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/dm644x.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

I did not notice this before, but the subject line for this and other
patches needs to be "ARM: davinci: "

Apart from that:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
