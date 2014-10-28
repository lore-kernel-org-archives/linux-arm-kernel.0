From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 00:38:43 +0000
Subject: [PATCH 4/8] regulator: max77686: Make regulator_desc array const
In-Reply-To: <1414422226-10948-5-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141028003843.GM18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:03:42PM +0100, Krzysztof Kozlowski wrote:
> The regulator_register() expects array of 'regulator_desc' to be const.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/a7807d11/attachment.sig>
