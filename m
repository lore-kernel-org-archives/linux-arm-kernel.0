From: carlo@caione.org (Carlo Caione)
Date: Sun, 9 Mar 2014 09:56:18 +0100
Subject: [linux-sunxi] Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
In-Reply-To: <20140309075148.GJ28112@sirena.org.uk>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140307182213.GC607@lukather>
 <CAOQ7t2YSidSPVSBrBzj3R1SYS_Xb10a2vfEs+u1DEkrhEJQCaQ@mail.gmail.com>
 <20140309075148.GJ28112@sirena.org.uk>
Message-ID: <20140309085618.GA4683@localhost.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 09, 2014 at 07:51:48AM +0000, Mark Brown wrote:
> On Sat, Mar 08, 2014 at 12:43:04PM +0100, Carlo Caione wrote:
> > On Fri, Mar 7, 2014 at 7:22 PM, Maxime Ripard
> > > On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:
> 
> > >> +     return platform_driver_register(&axp20x_regulator_driver);
> 
> > > I thought the AXP was only connected through I2C? How is that a
> > > platform device then?
> 
> > Not really. It is plain wrong.
> > I'll fix it in v2.
> 
> Are you sure this is wrong?  For MFDs the core MFD is a driver of
> whatever bus type is in use but the function drivers are platform
> devices which talk to the hardware via the core device.

ok, I spoke too soon. Sorry for the noise.

-- 
Carlo Caione
