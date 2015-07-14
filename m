From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 17:57:58 +0100
Subject: [PATCH 1/2] ASoC: Drop owner assignment from i2c_driver
In-Reply-To: <1436506231-8980-2-git-send-email-k.kozlowski@samsung.com>
References: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
 <1436506231-8980-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150714165758.GF11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 02:30:30PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/1bbc7fac/attachment.sig>
