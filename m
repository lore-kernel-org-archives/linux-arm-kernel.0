From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Apr 2014 23:11:43 +0100
Subject: [PATCH v2 11/16] ASoC: fsl-ssi: Fix register values when disabling
In-Reply-To: <1394887464-969-12-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-12-git-send-email-mpa@pengutronix.de>
Message-ID: <20140403221143.GH14763@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 01:44:19PM +0100, Markus Pargmann wrote:
> The bits we have to clear when disabling are different when the other
> stream is still active.

If this is a bug fix I'd have expected to see it at the start of the
series so we could merge it prior to the rest of the series (which is
new development) - what practical issues does this bug cause?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/a2119fab/attachment-0001.sig>
