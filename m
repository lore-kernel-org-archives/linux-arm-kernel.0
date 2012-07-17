From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 17 Jul 2012 10:48:41 +0100
Subject: [PATCH 4/9] ARM: vexpress: Initial common clock support
In-Reply-To: <CAJOA=zOe79YK06Rq2wmqkyGrHopyDi5ZWB25qL53g_nxu9T-TQ@mail.gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-5-git-send-email-pawel.moll@arm.com>
 <CACRpkdZGVgO-1jnfK=fpo73ryLDe05R0_hghwBxzDfbBK9jBRA@mail.gmail.com>
 <1342025844.25865.3.camel@hornet>
 <CAJOA=zOe79YK06Rq2wmqkyGrHopyDi5ZWB25qL53g_nxu9T-TQ@mail.gmail.com>
Message-ID: <1342518521.28167.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-16 at 21:15 +0100, Turquette, Mike wrote:
> > This patch is only a first step. I'm working now on a major rework of
> > the VE control infrastructure, and I do have drivers/clk/vexpress (can
> > be versatile, I don't really mind) directory in my local repo. This will
> > happen in time for the next merge window.
> 
> I'd rather not take any more patches this close to the 3.6 merge
> window.  How do you feel about holding onto this patch and
> implementing some of the longer term changes mentioned by Linus
> towards 3.7?

Sorry, I wasn't precise enough... What I meant:

1. The "micro-changes" (contained to arch/arm/mach-vexpress) are going
to 3.6 via arm-soc (already pulled by Arnd).

2. The "big changes" are waiting till 3.7 merge window, and the
drivers/clk/*/clk-vexpress.c will go through your tree.

Hope it makes sense,

Pawe?
