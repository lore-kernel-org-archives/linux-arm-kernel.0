From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Jun 2012 15:32:35 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20120601143235.GT24139@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47:26PM +0800, Lee Jones wrote:
> The 'name' field in 'struct of_regulator_match' expects to match with
> its corresponding regulator device node in the Device Tree. This patch
> renames each of the regulators in the ab8500 regulator driver so this
> is true.

Applied both, thanks.

> Cc: linux-kernel at vger.kernel.org

It's helpful to avoid inclding things like this (I mostly point this out
as you've got a much wider CC list so you clearly have some other system
that you're using to track where to send things).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120601/66f2b964/attachment.sig>
