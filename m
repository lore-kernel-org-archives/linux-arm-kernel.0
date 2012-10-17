From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Oct 2012 22:27:41 +0900
Subject: [PATCH 1/1] Documentation: Describe Device Tree bindings for
 GPIO Regulator driver
In-Reply-To: <1350374553-12678-1-git-send-email-lee.jones@linaro.org>
References: <1350374553-12678-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20121017132740.GS14199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 09:02:33AM +0100, Lee Jones wrote:
> Here we specify all non-standard bindings which can be used when
> requesting the use of an GPIO controlled regulator from Device Tree.

Applied both patches squashed together, thanks.  Please don't split
documentation from the code like this where the code is just a single
change - it's sensible where the code is a big series but for single
patch it's not helpful.

Given the subject line I'd be extremely likely to delete this patch
unread, Documentation: says "this isn't relevant".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/7cb1b9e3/attachment-0001.sig>
