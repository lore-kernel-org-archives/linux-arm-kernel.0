From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 22:32:23 +0000
Subject: [PATCH v5 1/4] regulator: max77686: Replace hard-coded opmode
 values with defines
In-Reply-To: <1414411911-5539-2-git-send-email-k.kozlowski@samsung.com>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141028223223.GI18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 01:11:47PM +0100, Krzysztof Kozlowski wrote:
> Add defines for regulator operating modes which should be more readable,
> especially if one does not have Maxim 77686 datasheet.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/3e1f3e5f/attachment.sig>
