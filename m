From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 19 Apr 2011 08:02:01 -0700
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTikLdmxXS-Ka8jpnnK5DD=0hH8K3rA@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTindYL9RHsc0MtY76RSr05qD0AU5Vg@mail.gmail.com>
	<BANLkTi=B9izP5N5iPnZDLdaQzBQ+egyo=A@mail.gmail.com>
	<BANLkTikLdmxXS-Ka8jpnnK5DD=0hH8K3rA@mail.gmail.com>
Message-ID: <BANLkTinu_uCw69ZnfuL12dFk+=X5wLt-Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 2:54 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
>
> But being serious now, what's the plan for the new code?
> I might get basic support for the Conexant/Ikanos SolosW SOC by the
> 2.6.41 merge window. Should I just send it in, or is there some
> moratorium in place, before the current code gets sorted out?

I don't have any set-in-stone plans. But I _am_ going to push back a
lot more on people who ask me to pull stuff that adds a lot of lines
to random platform drivers. If it all looks like "more of the same
crap" (another new irq driver, another stupid clock driver or pin
listing for gpio), I'll probably just say "screw it, they didn't even
try, why should I pull".

Linaro is trying to set up some kind of platform maintainership, we'll
see how that goes. But it will take some time to flesh out.

I personally try to avoid any "hard" rules. I'm going to use common
sense. But my common sense will have a lot of "we can't continue to
add crazy almost-duplicated code forever" in it.

              Linus
