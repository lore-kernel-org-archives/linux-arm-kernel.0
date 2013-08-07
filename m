From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 15:00:34 +0100
Subject: [PATCH V3 1/3] platform: Increase platform name size
In-Reply-To: <1375865122-5258-2-git-send-email-padma.v@samsung.com>
References: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
 <1375865122-5258-2-git-send-email-padma.v@samsung.com>
Message-ID: <20130807140034.GA6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 02:15:20PM +0530, Padmavathi Venna wrote:
> This patch increases the platform name size from 20 to 30 as one of
> i2s platform_device name in this patchset crosses the limit.

What is the name concerned?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/69ea3eb1/attachment.sig>
