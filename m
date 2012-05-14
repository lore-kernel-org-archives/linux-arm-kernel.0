From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 14 May 2012 15:29:00 +0300
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <20120512180441.GA11435@sirena.org.uk>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com>
 <20120509111335.GC20304@tbergstrom-lnx.Nvidia.com>
 <20120512180441.GA11435@sirena.org.uk>
Message-ID: <20120514122900.GZ20304@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 08:04:41PM +0200, Mark Brown wrote:
> On Wed, May 09, 2012 at 02:13:35PM +0300, Peter De Schrijver wrote:
> 
> > Ok. Thanks. One more question. We have some clocks with special features
> > such as request lines for clock outputs, delays for clocks recovered from
> > an external source or several divisors which are used based on the state
> > of the module which is served by the clock (eg. an idle divisor and an active
> > divisor). How should these be modelled?
> 
> For the idle/active divisors could they be represented as separate
> clocks?

I guess that might be possible. Need to look into it.

Cheers,

Peter.
