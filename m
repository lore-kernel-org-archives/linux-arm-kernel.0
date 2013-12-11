From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 14:12:40 +0000
Subject: [PATCH] mfd: s2mps11: Fix build after regmap field rename in
 sec-core.c
In-Reply-To: <1386770863-32247-1-git-send-email-k.kozlowski@samsung.com>
References: <1386770863-32247-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131211141240.GW11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 03:07:43PM +0100, Krzysztof Kozlowski wrote:
> Fix building of s2mps11 regulator and clock drivers after renaming
> regmap field in struct sec_pmic_dev in commit:
>  - "mfd/rtc: s5m: Fix register updating by adding regmap for RTC"

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/f83ec8b3/attachment.sig>
