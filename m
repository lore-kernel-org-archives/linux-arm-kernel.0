From: eric@anholt.net (Eric Anholt)
Date: Fri, 09 Feb 2018 11:12:45 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: Enable serial console on RPi 3
In-Reply-To: <20180207005309.14365-1-tuomas@tuxera.com>
References: <20180207005309.14365-1-tuomas@tuxera.com>
Message-ID: <87fu6aa02a.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tuomas Tynkkynen <tuomas@tuxera.com> writes:

> The Raspberry Pi 3 uses the 8250-based auxilary UART of the BCM2837 SoC
> as the primary serial console of the board, so enable it in the
> multiplatform defconfig.
>
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

I'm planning on putting this in -next once rc1 shows up, unless people
really want it in -fixes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180209/31ed4362/attachment.sig>
