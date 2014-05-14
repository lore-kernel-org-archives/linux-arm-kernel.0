From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 17:57:04 +0200
Subject: [PATCH] i2c: nomadik: Don't use IS_ERR for devm_ioremap
In-Reply-To: <1397139569-3906-1-git-send-email-ulf.hansson@linaro.org>
References: <1397139569-3906-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140514155703.GC12911@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 04:19:29PM +0200, Ulf Hansson wrote:
> devm_ioremap() returns NULL on error, not an error.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/7cdedf9b/attachment.sig>
