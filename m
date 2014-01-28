From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Jan 2014 16:25:32 +0000
Subject: [PATCH 15/18] regulator: max14577: Add support for max77836
 regulators
In-Reply-To: <1390911522-28209-16-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-16-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140128162532.GQ11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:18:39PM +0100, Krzysztof Kozlowski wrote:
> Add support for MAX77836 chipset and its additional two LDO regulators.
> These LDO regulators are controlled by the PMIC block with additional
> regmap (different I2C slave address).

Reviewed-by: Mark Brown <broonie@linaro.org>

This should go in with the rest of the changes I guess.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/84ec92c7/attachment.sig>
