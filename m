From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Aug 2013 16:26:05 -0700
Subject: [PATCH 1/3] ARM: vexpress: move spc driver back under
 mach-vexpress
In-Reply-To: <20130805095235.GB29090@e102568-lin.cambridge.arm.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <1375675793-16492-2-git-send-email-olof@lixom.net>
 <20130805095235.GB29090@e102568-lin.cambridge.arm.com>
Message-ID: <20130805232605.GA32172@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 10:52:35AM +0100, Lorenzo Pieralisi wrote:
> > +#include "spc.h"
> 
> Missing. Should we add it to mach-vexpress/include/mach ?

Oops, missed the git add on it.

No, include/mach is going away on all multiplatform platforms. Since the
exposed functions are only used in the other file in the same directory, local
include file is the way to go.

> I have not sent a patch to check what we should do first and if Pawel is
> ok with these changes.

Not sure I'm following, but see above.


-Olof
