From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Oct 2014 12:43:04 +0000
Subject: [PATCH v6 1/3] regulator: max77686: Add suspend disable for some
 LDOs
In-Reply-To: <1414581294-1315-2-git-send-email-k.kozlowski@samsung.com>
References: <1414581294-1315-1-git-send-email-k.kozlowski@samsung.com>
 <1414581294-1315-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141031124304.GS18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 12:14:52PM +0100, Krzysztof Kozlowski wrote:
> Some LDOs of Maxim 77686 PMIC support disabling during system suspend
> (LDO{2,6,7,8,10,11,12,14,15,16}). This was already implemented as part
> of set_suspend_mode function. In that case the mode was one of:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/7be74d5e/attachment.sig>
