From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 11:28:41 +0000
Subject: [GIT PULL] ARM: kprobes: big-endian support
In-Reply-To: <5332AB5A.90109@linaro.org>
References: <52D3D784.2000600@linaro.org> <53053769.5090100@linaro.org>
 <5332AB5A.90109@linaro.org>
Message-ID: <20140328112841.GF7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 12:26:34PM +0200, Taras Kondratiuk wrote:
> On 02/20/2014 12:59 AM, Taras Kondratiuk wrote:
> > On 01/13/2014 02:09 PM, Taras Kondratiuk wrote:
> >> Hi Russell,
> >>
> >> Please pull fixes for ARM Kprobes big-endian support.
> >>
> >> It is reworked initial Ben's series for big endian support [1].
> >> Dropped patches that are not directly related to kprobes.
> >> Current set of patches is enough to have functional BE kprobes.
> >>
> >> One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
> >> while it passes on Pandaboard. The issue is not related to this series
> >> and already present in v3.13-rc7.
> >>
> >> [1] http://www.spinics.net/lists/arm-kernel/msg285210.html
> >>
> > 
> > Hi Russell,
> > 
> > This pull request is based on 3.13-rc8, but it applies cleanly to
> > 3.14-rc3, because kprobes are not touched since then.
> > Do I need to resent a new pull request based on 3.14-rc3 anyway?
> > 
> 
> Hi Russell,
> 
> Is there any issue with this pull request?
> Should I do something to get it pulled?

There's nothing wrong, apart from me being far too busy hacking on really
crap code to care about reading much email - which means that lots of
email simply just gets buried and lost.

There is now a problem with this pull - it conflicts very badly with Dave
Long's uprobes code, which I've already pulled, so much so that I'm not
happy to do the conflict resolution since I know nothing about this code,
and it's a feature I don't make any use of.

I notice that Dave Long and yourself are both under the Linaro umbrella,
but there seems to be no coordination between yourselves, despite working
on the same code...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
