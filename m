From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 10:58:16 +0100
Subject: [PATCH v11 3/8] ASoC: generic: simple DT sound card
In-Reply-To: <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20130823095816.GF25263@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:05:56PM +0200, Markus Pargmann wrote:
> Simple sound card initialized using DT. When used with AC97, ac97-codec
> is used to automatically discover the used codec.

I've held back a bit on this one.  The reason is that it's adding a
separate card to the generic card which doesn't seem like the obvious
thing to do - obviously they have very similar goals, it's just that one
is for DT usage and the other isn't.  What's the reason for not adding
DT support to the generic card?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/e6ce8e27/attachment.sig>
