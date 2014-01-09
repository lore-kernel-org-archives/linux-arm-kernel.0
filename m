From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 9 Jan 2014 14:53:54 +0200
Subject: pull request for some small fixes
In-Reply-To: <20140108162757.27803.23767@quantum>
References: <20131223162705.GE3378@tbergstrom-lnx.Nvidia.com>
 <20140106054322.26907.37296@quantum>
 <20140107125122.GC26588@tbergstrom-lnx.Nvidia.com>
 <20140108162757.27803.23767@quantum>
Message-ID: <20140109125354.GU26588@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:27:57PM +0100, Mike Turquette wrote:
> Quoting Peter De Schrijver (2014-01-07 04:51:22)
> > On Mon, Jan 06, 2014 at 06:43:22AM +0100, Mike Turquette wrote:
> > > Quoting Peter De Schrijver (2013-12-23 08:27:05)
> > > > The following changes since commit 62ce7cd62f534023224912dc9b909963f26a38da:
> > > > 
> > > >   clk: tegra: fix __clk_lookup() return value checks (2013-11-28 15:09:22 +0200)
> > > > 
> > > > are available in the git repository at:
> > > >   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git clk-tegra-next-1
> > > 
> > > Hi Peter,
> > > 
> > > Do you intend for this to go as fixes for 3.13-rc8? The fixes are based
> > 
> > Yes.
> > 
> > > off of a commit from my clk-next branch.
> > > 
> > Do you want me to rebase them on 3.13-rc7?
> 
> Please do. I hope to send off a pull request today.
> 

The fixes are on top of the clk-tegra-for-3.14, so I can't apply them on 3.13-rc7 directly.

Cheers,

Peter.
