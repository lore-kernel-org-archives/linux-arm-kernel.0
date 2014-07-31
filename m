From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Jul 2014 20:24:42 +0100
Subject: [PATCH] regulator: tps65090: Set voltage for fixed regulators
In-Reply-To: <1406809865-13115-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1406809865-13115-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140731192442.GM17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 02:31:05PM +0200, Javier Martinez Canillas wrote:
> According to the tps65090 data manual [0], the DCDC1 and DCDC2
> step-down converters and the LDO's have a fixed output voltage.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/094036a5/attachment.sig>
