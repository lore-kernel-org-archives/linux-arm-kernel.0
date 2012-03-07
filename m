From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Mar 2012 16:28:22 +0000
Subject: [PATCH v9] Regulator: Add Anatop regulator driver
In-Reply-To: <20120307153622.GC17745@game.jcrosoft.org>
References: <1331126658-26926-1-git-send-email-paul.liu@linaro.org>
 <20120307132225.GB17745@game.jcrosoft.org>
 <20120307134551.GL3107@opensource.wolfsonmicro.com>
 <20120307153622.GC17745@game.jcrosoft.org>
Message-ID: <20120307162821.GP3107@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 04:36:22PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> > This really doesn't seem at all sane for a device which is already
> > vendor specific, it's just noise in the bindings.

> No it's

...?

> Here is a good example as we have regulator generic binding & vendor
> specific bindig

It's not vendor specific, it's device specific and people are doing it
even for devices with no generic bindings at all which is particularly
silly.

Device specific prefixes probably make sense, but vendor specific ones
are just noise.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/19e1a699/attachment.sig>
