From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 May 2012 08:36:49 +0100
Subject: [PATCH 11/18] regulator: Enable the ab8500 for Device Tree
In-Reply-To: <1337262323-27692-12-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-12-git-send-email-lee.jones@linaro.org>
Message-ID: <20120518073648.GD4073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 02:45:16PM +0100, Lee Jones wrote:
> Here we setup the ab8500 regulator driver for DT. We first do
> this in the normal way, by providing a match structure during
> initialisation, but then we provide information so that
> whilst probing we can use existing data structures to do DT
> look-ups.

Applied, thanks.  This and your previous patch look really good now!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/8656c2cf/attachment.sig>
