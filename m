From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 18:40:21 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140108183006.GC9724@e102568-lin.cambridge.arm.com>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
 <20140108183006.GC9724@e102568-lin.cambridge.arm.com>
Message-ID: <20140108184021.GW31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 06:30:06PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 08, 2014 at 05:10:10PM +0000, Mark Brown wrote:

> > +#include <linux/slab.h>

> Nitpick, <linux/slab.h> does not belong in this patch. There are other
> includes that should be moved to the respective patch (percpu.h ?) where
> they are actually used.

I can move this one but honestly I'm having an extremely difficult time
summoning up the enthusiasm for looking for others and moving them - the
practical impact will not be substantial.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/6bf8d0e3/attachment.sig>
