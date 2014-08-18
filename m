From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Aug 2014 10:23:24 -0500
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <1408350762-15520-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1408350762-15520-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408350762-15520-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140818152324.GG14537@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:32:41AM +0200, Javier Martinez Canillas wrote:
> The MAX77802 PMIC has 10 high-efficiency Buck and 32 Low-dropout
> (LDO) regulators. This patch adds support for all these regulators
> found on the MAX77802 PMIC and is based on a driver added by Simon
> Glass to the Chrome OS kernel 3.8 tree.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/2ae77255/attachment-0001.sig>
