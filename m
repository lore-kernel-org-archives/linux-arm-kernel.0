From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 25 Jan 2011 15:16:30 +0000
Subject: [PATCH] ASoC: correct link specifications for corgi, poodle
	and spitz
In-Reply-To: <20110125150317.GG31453@opensource.wolfsonmicro.com>
References: <1295637257-28299-1-git-send-email-dbaryshkov@gmail.com>
	<20110125150317.GG31453@opensource.wolfsonmicro.com>
Message-ID: <1295968590.3322.256.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-25 at 15:03 +0000, Mark Brown wrote:
> On Fri, Jan 21, 2011 at 10:14:17PM +0300, Dmitry Eremin-Solenikov wrote:
> > ASoC DAI link descriptions for Corgi, Poodle and Spitz platforms
> > contained incorrect names for cpu_dai and codec, which effectievly disabled sound
> > on theese platforms. Fix that errors.
> 
> Ccing in Liam who you forgot to CC - please make sure you CC all
> maintainers on patches.
> 
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > ---
> >  sound/soc/pxa/corgi.c  |    4 ++--
> >  sound/soc/pxa/poodle.c |    2 +-
> >  sound/soc/pxa/spitz.c  |    4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >

Looks fine to me.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
