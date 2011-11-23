From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Nov 2011 14:01:22 -0800
Subject: [PATCH 01/17] arm/tegra: board-dt: audio: Enable clocks, fix
 AUXDATA
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C708@HQMAIL01.nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-2-git-send-email-swarren@nvidia.com>
 <20111123103858.GK4332@opensource.wolfsonmicro.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C708@HQMAIL01.nvidia.com>
Message-ID: <20111123220122.GA7655@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 09:44:54AM -0800, Stephen Warren wrote:
> Mark Brown wrote at Wednesday, November 23, 2011 3:39 AM:
> > On Tue, Nov 22, 2011 at 06:21:09PM -0700, Stephen Warren wrote:
> > 
> > >  	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_DVC_BASE, "tegra-i2c.3", NULL),
> > >  	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.0", NULL),
> > > -	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.1", NULL),
> > > +	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S2_BASE, "tegra-i2s.1", NULL),
> > 
> > This looks like a straight bug fix which is independant of the below
> > change?
> 
> That is true.
> 
> Olof/Colin, do you want me to split this up?

Sure, it's good practice. Indicate if you want it in for 3.2, but given that
this is the first user of the binding I am guessing no.


-Olof
