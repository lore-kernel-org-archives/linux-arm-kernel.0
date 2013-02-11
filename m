From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 11 Feb 2013 12:03:10 +0200
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <20130208140301.GA23979@arwen.pp.htv.fi>
References: <1360330602-30472-1-git-send-email-pdeschrijver@nvidia.com>
 <1360330602-30472-9-git-send-email-pdeschrijver@nvidia.com>
 <20130208140301.GA23979@arwen.pp.htv.fi>
Message-ID: <20130211100310.GZ3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 03:03:02PM +0100, Felipe Balbi wrote:
> * PGP Signed by an unknown key
> 
> Hi,
> 
> On Fri, Feb 08, 2013 at 03:36:40PM +0200, Peter De Schrijver wrote:
> >  	tegra_car: clock {
> > -		compatible = "nvidia,tegra114-car, nvidia,tegra30-car";
> > +		compatible = "nvidia,tegra114-car";
> 
> trailing change or intentional ?

No, the Tegra30 car driver shouldn't be used for Tegra114.

Cheers,

Peter.
