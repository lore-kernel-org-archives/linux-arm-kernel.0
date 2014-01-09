From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jan 2014 18:18:22 +0000
Subject: [PATCH v10 2/4] arm64: topology: Add support for topology DT
 bindings
In-Reply-To: <20140109174458.GA13541@e102568-lin.cambridge.arm.com>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-3-git-send-email-broonie@kernel.org>
 <20140109174458.GA13541@e102568-lin.cambridge.arm.com>
Message-ID: <20140109181822.GN12858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 05:44:58PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Jan 09, 2014 at 05:05:04PM +0000, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> > +#include <linux/slab.h>

> Move it to patch 3 please where kcalloc is actually used.

Gah, forgot that git format-patch doesn't overwrite patches - it is
actually moved in the code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/5828b7fb/attachment.sig>
