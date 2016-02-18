From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 18:58:47 -0800
Subject: [PATCH 1/3] ARM: bcm2835_defconfig: rebuild on next-20160205
In-Reply-To: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
References: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87h9h6yba0.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> This separates explicit changes desired in later patches from "automatic"
> or irrelevant changes caused solely by Kconfig changes.
>
> make ARCH=arm bcm2835_defconfig
> make ARCH=arm savedefconfig
> mv defconfig arch/arm/configs/bcm2835_defconfig
>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Pulled to -next (and thanks for the help with debugging the boot
troubles!)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/86bc8c7e/attachment.sig>
