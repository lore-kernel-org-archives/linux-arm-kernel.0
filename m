From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Mar 2013 18:52:26 +0000
Subject: [PATCH 01/10] imx-ssi: Fix AC97 rates
In-Reply-To: <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130312185225.GS19942@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 07:33:02PM +0100, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> This device supports multiple rates as described in later AC97
> standards. This patch allows playback of different sample frequencies
> without conversion.

Applied, but some notes about why this is already supported would be
useful and *always* use subject lines appropriate for the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/9702515a/attachment.sig>
