From: eric@anholt.net (Eric Anholt)
Date: Wed, 14 Nov 2018 15:28:07 -0800
Subject: [PATCH] ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2
 camera driver
In-Reply-To: <1542229864-27695-1-git-send-email-stefan.wahren@i2se.com>
References: <1542229864-27695-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <8736s3xmrc.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This enables the bcm2835-camera driver, which depends on bcm2835-vchiq.
> After that we gain more test coverage (e.g. Kernel CI).
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/configs/bcm2835_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> Hi, i will submit a patch series to address those probing issues. But this is
> independent from this patch.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/2287ba60/attachment.sig>
