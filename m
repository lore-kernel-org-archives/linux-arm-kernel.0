From: eric@anholt.net (Eric Anholt)
Date: Wed, 11 Apr 2018 08:56:32 -0700
Subject: [PATCH v6 0/5] drm/blend: Support generic plane-wide alpha
In-Reply-To: <cover.637c90251afd1eb6d5564a3c50beda2a3d51160a.1523432341.git-series.maxime.ripard@bootlin.com>
References: <cover.637c90251afd1eb6d5564a3c50beda2a3d51160a.1523432341.git-series.maxime.ripard@bootlin.com>
Message-ID: <87fu41pwi7.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@bootlin.com> writes:

> Hi,
>
> This serie aims at enhancing the support for plane-wide alpha in the
> drivers that are implementing it at the moment, by turning it into a
> generic property and converting the drivers (rcar-du and atmel-hclcdc). It
> also introduces support for it in the sun4i driver.
>
> Let me know what you think,
> Maxime
>
> Changes from v5:
>   - Added back a comment about the pixel values not being pre-multiplied as
>     suggested by Laurent

I like that comment.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180411/47323eee/attachment.sig>
