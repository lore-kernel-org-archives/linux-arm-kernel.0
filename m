From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 18:08:29 +0000
Subject: [PATCH] ASoC: samsung: ASoC: samsung: Fix IISMOD setting in
 i2s_set_sysclk()
In-Reply-To: <1416477797-27332-1-git-send-email-padma.v@samsung.com>
References: <1416477797-27332-1-git-send-email-padma.v@samsung.com>
Message-ID: <20141121180829.GV3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 03:33:17PM +0530, Padmavathi Venna wrote:
> In the i2s_set_sysclk() callback we are currently clearing all bits
> of the IISMOD register in i2s_set_sysclk. It's due to an incorrect
> mask used for the AND operation which is introduced in commit
> a5a56871f804edac93a53b5e871c0e9818fb9033 (ASoC: samsung:
> add support for exynos7 I2S controller) and also adds the missing
> break statement.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/2251f2c9/attachment.sig>
