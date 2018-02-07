From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 7 Feb 2018 20:46:57 +0530
Subject: [PATCH v6 37/41] ARM: da8xx: Remove legacy clock init
In-Reply-To: <1516468460-4908-38-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-38-git-send-email-david@lechnology.com>
Message-ID: <310debb9-9cd6-35d6-fd4d-664d13a79533@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> This removes the unused legacy clock init code from
> arch/arm/mach-davinci/{devices,usb}-da8xx}.c.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Can you please mention SATA and USB in subject line and in patch
description?

Apart from that:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
