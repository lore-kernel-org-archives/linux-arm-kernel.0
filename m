From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 16 Jan 2013 06:06:12 +0100
Subject: [v3 6/9] ARM: dt: tegra114: Add new SoC base, Tegra 114 SoC
In-Reply-To: <20130115172733.GS4118@tbergstrom-lnx.Nvidia.com>
References: <1358237598-32413-7-git-send-email-hdoyu@nvidia.com><50F58A13.10301@wwwdotorg.org><20130115172733.GS4118@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130116.070612.390154383947803922.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver <pdeschrijver@nvidia.com> wrote @ Tue, 15 Jan 2013 18:27:33 +0100:

> On Tue, Jan 15, 2013 at 05:55:47PM +0100, Stephen Warren wrote:
> > On 01/15/2013 01:13 AM, Hiroshi Doyu wrote:
> > > Initial support for Tegra 114 SoC. This is expected to be included in
> > > the board DTS files, Tegra 114 SoC based evaluation board family.
> > 
> > This series looks fine to me. Assuming no other comments, I'll apply
> > once CCF is applied and you've done the rebase you mentioned for patch 2.
> > 
> > Note that I'll apply most patches to Tegra's for-3.9/soc branch (the
> > code) but the 3 device tree patches to Tegra's for-3.9/dt branch, since
> > it's fine for the DT files to appear later than the code supporting the
> > SoC, since this is all new features.
> > 
> > One question: The .dts files don't include any clocks properties. I
> > assume Peter will add these when he posts the Tegra114 CCF code?
> 
> Yes. I will add those as part of the Tegra114 CCF series.

Once Tegra114 CCF comes, the 2nd one can be dropped.
