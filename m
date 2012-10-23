From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 14:08:59 +0100
Subject: [PATCH] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <1350994116-9127-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350994116-9127-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121023130858.GA4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 02:08:36PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.
> 
> This patch introduced runtime PM issues and is not needed at all.
> Thus we should revert it.

As covered elsewhere I applied a revert myself.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/41af29aa/attachment.sig>
