From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Mar 2014 18:52:52 +0000
Subject: [PATCH v3 3/5] regulator: add bcm590xx regulator driver
In-Reply-To: <1394552775-31264-4-git-send-email-mporter@linaro.org>
References: <1394552775-31264-1-git-send-email-mporter@linaro.org>
 <1394552775-31264-4-git-send-email-mporter@linaro.org>
Message-ID: <20140311185252.GX28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 11:46:13AM -0400, Matt Porter wrote:
> Add a regulator driver for the BCM590xx PMU voltage regulators.
> The driver supports LDOs and DCDCs in normal mode only. There is
> no support for low-power mode or power sequencing.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/f7b63f13/attachment.sig>
