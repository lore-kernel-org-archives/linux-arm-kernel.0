From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 22:32:30 +0000
Subject: [PATCH v5 2/4] regulator: max77686: Store opmode non-shifted
In-Reply-To: <1414411911-5539-3-git-send-email-k.kozlowski@samsung.com>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141028223230.GJ18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 01:11:48PM +0100, Krzysztof Kozlowski wrote:
> Introduce simple helper for calculating the shift for OPMODE field in
> registers. This allows storing the current value of opmode in
> non-shifted form and simplifies a little set_suspend_disable and enable
> functions. Additionally this will allow adding support LDOs to the
> existing set_suspend_disable function.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/7ae748ae/attachment.sig>
