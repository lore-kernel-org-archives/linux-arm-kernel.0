From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 20:59:39 +0100
Subject: [PATCH 3/4] regulator: bcm590xx: add support for regulators on
 secondary i2c slave
In-Reply-To: <1397501428-8857-4-git-send-email-mporter@linaro.org>
References: <1397501428-8857-1-git-send-email-mporter@linaro.org>
 <1397501428-8857-4-git-send-email-mporter@linaro.org>
Message-ID: <20140414195939.GR25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 02:50:27PM -0400, Matt Porter wrote:
> The bcm590xx mfd driver now exposes a second regmap descriptor making
> the registers for regulators on the secondary i2c slave address
> available.  Add support for GPLDO1-6 and VBUS regulators found within
> this register range.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>

Acked-by: Mark Brown <broonie@linaro.org>

though if possible I'd prefer to merge this into the regulator tree
which would need a cross tree merge with MFD.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/74dc2421/attachment-0001.sig>
