From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Nov 2017 12:32:17 -0800
Subject: [PATCH RFC] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
In-Reply-To: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87k1yjcqzy.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
>
> This patch also fixes the dt-bindings accordlingly.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171121/9233e338/attachment.sig>
