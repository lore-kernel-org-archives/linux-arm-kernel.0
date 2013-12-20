From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 20 Dec 2013 21:10:48 +0100
Subject: [PATCHv12 00/49] ARM: TI SoC clock DT conversion
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Message-ID: <20131220201047.GA12085@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 06:34:19PM +0200, Tero Kristo wrote:
> Hopefully final post of this series. At least this is going to be the last
> post this year as I will be going to x-mas vacation and won't be back before
> Jan 2nd. This time I just sent the patches that have changes in them,
> the missing ones are exactly the same as in v11.

> Testing done:
> - omap3-beagle: boot, suspend/resume (ret), suspend/resume (off)
> - omap4-panda-es: boot, suspend/resume (ret)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot

Booting the 3.13-rc4-dt-clks-v12 branch on my Nokia N900 works:

Tested-By: Sebastian Reichel <sre@debian.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/95750d5b/attachment.sig>
