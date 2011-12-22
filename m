From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 22 Dec 2011 11:27:51 +0000
Subject: [PATCH v4] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <alpine.LFD.2.02.1112191201360.2907@xanadu.home>
References: <1324305365-22514-1-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1112191201360.2907@xanadu.home>
Message-ID: <20111222112751.GB2573@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:03:32PM -0500, Nicolas Pitre wrote:
> On Mon, 19 Dec 2011, Dave Martin wrote:
> 
> > This patch adds some endianness-agnostic helpers to convert machine
> > instructions between canonical integer form and in-memory
> > representation.
> > 
> > A canonical integer form for representing instructions is also
> > formalised here.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > ---
> > Changes since v1:
> > 
> > v4: Rebase on top of Leif's patch which created <asm/opcodes.h>
> >     ARM: 7206/1: Add generic ARM instruction set condition code checks.
> 
> In that case you might be able to put your patch in the patch system, 
> and then go back to add a note for Russell mentioning 7206/1 is a 
> prerequisite.

OK, I'll try and do that.

Cheers
---Dave
