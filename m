From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 24 Jul 2015 17:20:25 +0530
Subject: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
In-Reply-To: <1437568344-18889-4-git-send-email-fcooper@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com>
Message-ID: <55B22681.3060000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 July 2015 06:02 PM, Franklin S Cooper Jr wrote:
> SPI Davinci driver has been updated to allow SOCs to specify their minimum
> prescale value. Update the various SOCs board files that use this driver with
> their proper prescaler limit.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

in case Mark is okay to take it through his tree. It does not clash with
anything else I have for mach-davinci.

Thanks,
Sekhar
