From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 15:45:01 +0100
Subject: breaking DT compatibility (was: Re: [PATCH v4] clk: sunxi:
 Refactor A31 PLL6 so that it can be reused)
In-Reply-To: <20160210143755.GE31506@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
 <20160210143755.GE31506@lukather>
Message-ID: <3703606.9ibfaTDDFx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 February 2016 15:37:55 Maxime Ripard wrote:
> Hi Rob,
> 
> On Wed, Feb 10, 2016 at 07:42:02AM -0600, Rob Herring wrote:
> > On Wed, Feb 10, 2016 at 6:30 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > > Hi,
> > >
> > > just a ping:
> > >
> > > Are we really OK with breaking existing DTs in 4.6? (per the code in
> > > -next: f7d372ba54ea04d528a291b8dbe34716507bb60b, which is this patch).
> > 
> > I only warn and make sure people are aware of the issue. I leave that
> > up to platform maintainers to decide. It depends on the maturity of
> > the platform and users.
> 
> The impacted SoCs support is really partial. For the most supported
> one, big things like display or sound are totally missing, and we
> still update them on a regular basis to add support for new
> devices. As such, users are very likely to upgrade the DT from one
> version to another just because there's new devices available to
> them. And the newest SoC impacted just got introduced in 4.5, and only
> has the UART and MMC devices available.
> 
> 

I think the main problems we had were around people building their
own boards and maintaining out-of-tree dts files.

	Arnd
