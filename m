From: eric@anholt.net (Eric Anholt)
Date: Thu, 22 Feb 2018 15:30:53 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: Enable serial console on RPi 3
In-Reply-To: <87fu6aa02a.fsf@anholt.net>
References: <20180207005309.14365-1-tuomas@tuxera.com>
 <87fu6aa02a.fsf@anholt.net>
Message-ID: <874lm8r49e.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> [ Unknown signature status ]
> Tuomas Tynkkynen <tuomas@tuxera.com> writes:
>
>> The Raspberry Pi 3 uses the 8250-based auxilary UART of the BCM2837 SoC
>> as the primary serial console of the board, so enable it in the
>> multiplatform defconfig.
>>
>> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
>
> I'm planning on putting this in -next once rc1 shows up, unless people
> really want it in -fixes.

Merged to bcm2835-defconfig-next.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/073e528c/attachment.sig>
