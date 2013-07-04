From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 16:50:28 +0100
Subject: [PATCH] ASoC: wm8962: fix NULL pdata pointer
In-Reply-To: <1372950840-13393-1-git-send-email-shawn.guo@linaro.org>
References: <1372950840-13393-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130704155028.GF27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 11:14:00PM +0800, Shawn Guo wrote:
> There is an error in merge commit 384b834 on conflict resolution which
> causes the following NULL pdata pointer bug.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/79a0e972/attachment-0001.sig>
