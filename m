From: eric@anholt.net (Eric Anholt)
Date: Thu, 21 Jul 2016 08:23:53 -0700
Subject: [PATCH] ARM: dont specify STACKPROTECTOR in defconfigs
In-Reply-To: <20160721151134.5803-1-paul.gortmaker@windriver.com>
References: <20160721151134.5803-1-paul.gortmaker@windriver.com>
Message-ID: <878twvypyu.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> Note the output from the following:
>
>    $ git grep STACKPROTECTOR arch/arm/configs/
>    arch/arm/configs/aspeed_g4_defconfig:CONFIG_CC_STACKPROTECTOR_STRONG=y
>    arch/arm/configs/aspeed_g5_defconfig:CONFIG_CC_STACKPROTECTOR_STRONG=y
>    arch/arm/configs/bcm2835_defconfig:CONFIG_CC_STACKPROTECTOR_REGULAR=y
>    $

I don't see why rpi1 shoud be special, so for bcm2835:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/5c207bcf/attachment.sig>
