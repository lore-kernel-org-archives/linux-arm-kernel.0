From: horms@verge.net.au (Simon Horman)
Date: Mon, 24 Sep 2018 17:38:04 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.20
In-Reply-To: <20180923131817.t2lj6d2sb7bp6lqi@localhost>
References: <cover.1536824376.git.horms+renesas@verge.net.au>
 <20180923131817.t2lj6d2sb7bp6lqi@localhost>
Message-ID: <20180924153803.qfy2cu64cjpimi37@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2018 at 06:18:17AM -0700, Olof Johansson wrote:
> Hi Simon,
> 
> On Thu, Sep 13, 2018 at 11:08:18AM +0200, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC DT updates for v4.20.
> > 
> > I am sending out this pull-request at this time as there are a number
> > of patches queued up in my arm (32) DT branch and I hope that this
> > will ease the burden later on in the development cycle. I expect to
> > send a follow-up pull-request for this branch at the usual pre-rc6 timing.
> 
> This is a good amount of patches, feel free to flush your queue around the time
> it builds up to about this amount -- no need to hold on to them longer.

Will do. Often the DT branches accumulate quite a lot of patches
in the course of an entire development cycle. I'll plan to flush
them out to you when that happens.

> 
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > 
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.20
> > 
> > for you to fetch changes up to 1926bd6bf20fe306797fbf366902674d2d6c20cc:
> > 
> >   ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions (2018-09-06 11:31:35 +0200)
> 
> Merged, thanks!
> 
> 
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC DT Updates for v4.20
> > 
> > * R-Car Gen1 SoCs: Include product name in DTSI files for ease of maintenance
> > * R-Car Gen2 SoCs:
> >   - Convert to new DU DT bindings
> >   - Correct SATA device sizes to 2 MiB
> > * R-Car H2 (r8a7790) based Porter board: Add DA9063 OnKey PMIC node
> > * R-Car E2 (r8a7794) based Silk board: Add DA9063 PMIC, RTC and OnKey nodes
> > * R-Car M2-N (r8a7793) based Gose board: Add DA9210 node for CPU DVFS
> > * RZ/G1C (R8A77470) SoC:
> >   - Add GPIO nodes
> >   - Add PFC support
> >   - Use r8a77470-sysc binding definitions
> > * RZ/G1C (r8a77470) iW-RainboW-G23S dev platform:
> >   - Specify EtherAVB PHY IRQ
> >   - Add pinctl support for scif1
> > * RZ/N1D (r9a06g032) SoC: Use r9a06g032-sysctrl binding definitions
> 
> I like this format! It's nice, terse and to the point, and it makes
> it a bit easier to see commonalities across the large number of similar
> (and different) product and platform names.
> 
> Thanks a lot for being flexible and trying different things here!

Thanks for your patience, I'm glad the new format works for you.
