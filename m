From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 May 2014 10:47:11 +0100
Subject: [PATCH v8 5/8] arm64: Add ftrace support
In-Reply-To: <20140529080705.GD29812@arm.com>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-6-git-send-email-takahiro.akashi@linaro.org>
 <20140528201955.GJ5099@sirena.org.uk>
 <20140529080705.GD29812@arm.com>
Message-ID: <20140529094711.GM5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 09:07:05AM +0100, Will Deacon wrote:
> On Wed, May 28, 2014 at 09:19:55PM +0100, Mark Brown wrote:
> > On Wed, Apr 30, 2014 at 06:54:33PM +0900, AKASHI Takahiro wrote:

> > > +#include <linux/linkage.h>
> > > +#include <asm/ftrace.h>
> > > +#include <asm/insn.h>

> > asm/insn.h contains a bunch of C stuff which won't build without
> > __ASSEMBLY__ guards unless I'm missing something (I'm working with a
> > non-mainline tree so I might be).

> The guards are added earlier in this series.

Yeah, I discussed with Akashi-san later - the guard patch didn't
actually make it onto the list properly, neither of us has a copy
locally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140529/92d8ef66/attachment-0001.sig>
