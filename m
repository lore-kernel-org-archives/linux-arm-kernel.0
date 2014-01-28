From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Jan 2014 16:19:00 +0000
Subject: [PATCH 01/18] regulator: max14577: Remove unused state container
 definition
In-Reply-To: <1390911522-28209-2-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140128161900.GP11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:18:25PM +0100, Krzysztof Kozlowski wrote:
> Remove the "struct max14577_regulator" because this is not used
> anywhere. It should be removed earlier along with changing the driver
> after review on the mailing lists.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/f46a547b/attachment.sig>
