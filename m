From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 6 Aug 2013 09:55:50 +0100
Subject: [PATCH 1/3] ARM: vexpress: move spc driver back under
 mach-vexpress
In-Reply-To: <20130805232605.GA32172@quad.lixom.net>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <1375675793-16492-2-git-send-email-olof@lixom.net>
 <20130805095235.GB29090@e102568-lin.cambridge.arm.com>
 <20130805232605.GA32172@quad.lixom.net>
Message-ID: <20130806085549.GA18810@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 12:26:05AM +0100, Olof Johansson wrote:
> On Mon, Aug 05, 2013 at 10:52:35AM +0100, Lorenzo Pieralisi wrote:
> > > +#include "spc.h"
> > 
> > Missing. Should we add it to mach-vexpress/include/mach ?
> 
> Oops, missed the git add on it.
> 
> No, include/mach is going away on all multiplatform platforms. Since the
> exposed functions are only used in the other file in the same directory, local
> include file is the way to go.
> 
> > I have not sent a patch to check what we should do first and if Pawel is
> > ok with these changes.
> 
> Not sure I'm following, but see above.

I just wanted to say that sending a patch to fix the issue was inappropriate
because it depended on where the spc.h has to be created and did not
know if Pawel was ok with the idea of moving spc back to mach-vexpress.

I am ok with your changes, thank you very much.

Lorenzo
