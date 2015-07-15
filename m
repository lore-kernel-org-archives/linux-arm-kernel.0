From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Jul 2015 10:45:33 +0100
Subject: [PATCH v2 2/2] ASoC: Drop owner assignment from platform_driver
In-Reply-To: <55A60A54.7040004@samsung.com>
References: <1436934105-12700-1-git-send-email-k.kozlowski@samsung.com>
 <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
 <55A60A54.7040004@samsung.com>
Message-ID: <20150715094533.GL11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 04:23:00PM +0900, Krzysztof Kozlowski wrote:

> > platform_driver does not need to set an owner because
> > platform_driver_register() will set it.

> D'oh! I forgot to include ack from Koro Chen given here:
> https://lkml.org/lkml/2015/7/12/218

That and the fact that it's already applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150715/cb3e3d5d/attachment.sig>
