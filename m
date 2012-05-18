From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 May 2012 16:36:15 +0100
Subject: [PATCH 05/16] regulator: db8500-prcmu: Separate regulator
 registration from probe
In-Reply-To: <1337330355-17747-6-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20120518153615.GF4039@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 09:39:04AM +0100, Lee Jones wrote:
> This will provide us with a convenient way to register regulators when
> booting with Device Tree both enabled & disabled and will save us a
> great deal of code duplication in time.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/8cc8d638/attachment.sig>
