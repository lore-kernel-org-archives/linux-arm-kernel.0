From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 12 Jun 2018 01:00:01 -0700
Subject: [GIT PULL] Allwinner clock changes for 4.18
In-Reply-To: <CAGb2v67DOgnW=gesPxgmxZJWieZkzjPJm5mt7eW15HgUP3_SZg@mail.gmail.com>
References: <20180521115947.wqrnv2hczate65lz@flea>
 <CAK7LNASgetmPKKS8AhYXqSSEFCi+q0ASZ68M0SECJT5EbAU4XQ@mail.gmail.com>
 <CAGb2v67DOgnW=gesPxgmxZJWieZkzjPJm5mt7eW15HgUP3_SZg@mail.gmail.com>
Message-ID: <152879040155.16708.9862482085365718831@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chen-Yu Tsai (2018-06-11 00:53:41)
> Hi,
> 
> On Mon, Jun 11, 2018 at 10:00 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > Hi Maxime,
> >
> >
> > 2018-05-21 20:59 GMT+09:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> >> Hi Mike, Stephen,
> >>
> >> Please merge the following changes for the next merge window, thanks!
> >>
> >> Maxime
> >>
> >> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> >>
> >>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.18
> >>
> >> for you to fetch changes up to 17de4c857b1f74b90967f7e7fd5ff81be61dc044:
> >>
> >>   clk: sunxi-ng: r40: export a regmap to access the GMAC register (2018-05-17 14:02:07 +0800)
> >>
> >> ----------------------------------------------------------------
> >> Allwinner clock changes for 4.18
> >>
> >> Not a lot of changes for this release, but two quite important features
> >> were added: the H6 PRCM clock support, and the needed changes to the R40
> >> clock driver to allow for the EMAC to operate.
> >>
> >> ----------------------------------------------------------------
> >> Icenowy Zheng (3):
> >>       clk: sunxi-ng: add support for H6 PRCM CCU
> >>       clk: sunxi-ng: r40: rewrite init code to a platform driver
> >>       clk: sunxi-ng: r40: export a regmap to access the GMAC register
> >>
> >
> >
> >
> > Why was my patch "clk: sunxi-ng: replace lib-y with obj-y"
> > not included in the pull request?
> >
> >
> > You said "I've picked it up"
> > https://patchwork.kernel.org/patch/10348031/
> 
> It looks like it was accidentally dropped after a rebase.
> Not quite sure what happened there. Maxime?
> 

I can directly pick and send as fix for clk-fixes targeting rc2.
