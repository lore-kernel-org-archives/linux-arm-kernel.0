From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Jul 2014 11:36:28 +0200
Subject: [PATCH] ASoC: s3c64xx/smartq: use dynamic registration
In-Reply-To: <1404898043-1160870-1-git-send-email-arnd@arndb.de>
References: <1404898043-1160870-1-git-send-email-arnd@arndb.de>
Message-ID: <20140709093628.GQ30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 11:27:23AM +0200, Arnd Bergmann wrote:

>  arch/arm/mach-s3c64xx/mach-smartq.c | 10 +++++
>  sound/soc/samsung/smartq_wm8987.c   | 73 ++++++++++++++-----------------------

> +#include <linux/platform_data/asoc-s3c-smartq.h>

Looks like you forgot to add this file to your commit so it won't build.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/f8ea4ce6/attachment.sig>
