From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 19 Apr 2011 17:20:56 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTinu_uCw69ZnfuL12dFk+=X5wLt-Ug@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTindYL9RHsc0MtY76RSr05qD0AU5Vg@mail.gmail.com>
	<BANLkTi=B9izP5N5iPnZDLdaQzBQ+egyo=A@mail.gmail.com>
	<BANLkTikLdmxXS-Ka8jpnnK5DD=0hH8K3rA@mail.gmail.com>
	<BANLkTinu_uCw69ZnfuL12dFk+=X5wLt-Ug@mail.gmail.com>
Message-ID: <20110419152056.GB19199@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:02 Tue 19 Apr     , Linus Torvalds wrote:
> On Mon, Apr 18, 2011 at 2:54 PM, Alexey Zaytsev
> <alexey.zaytsev@gmail.com> wrote:
> >
> > But being serious now, what's the plan for the new code?
> > I might get basic support for the Conexant/Ikanos SolosW SOC by the
> > 2.6.41 merge window. Should I just send it in, or is there some
> > moratorium in place, before the current code gets sorted out?
> 
> I don't have any set-in-stone plans. But I _am_ going to push back a
> lot more on people who ask me to pull stuff that adds a lot of lines
> to random platform drivers. If it all looks like "more of the same
> crap" (another new irq driver, another stupid clock driver or pin
> listing for gpio), I'll probably just say "screw it, they didn't even
> try, why should I pull".
> 
> Linaro is trying to set up some kind of platform maintainership, we'll
> see how that goes. But it will take some time to flesh out.
> 
> I personally try to avoid any "hard" rules. I'm going to use common
> sense. But my common sense will have a lot of "we can't continue to
> add crazy almost-duplicated code forever" in it.
I'm actually working on AT91 cleanup as switch to clkdev and early devices,
etc...
but I do not remove too much line on contrary I may add more

I'll later remove duplicate ressources and refactor the code to allow multiple
soc in the same kernel but this will result in a LOTS of changsets.

Best Regards,
J.
