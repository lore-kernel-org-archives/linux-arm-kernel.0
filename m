From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Tue, 5 Jan 2016 12:30:20 +0100
Subject: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
In-Reply-To: <20151231173844.GD11863@localhost.localdomain>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
 <20151231173844.GD11863@localhost.localdomain>
Message-ID: <20160105113020.GK22661@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 December 2015 09:38:45 Eduardo Valentin wrote:
> > +
> > +		bandgap {
> > +			reg = <0x48002524 0x4>;
> > +			compatible = "ti,omap36xx-bandgap";
> 
> Can you please already add on both cases
> 
> #thermal-sensor-cells = <0>;
> ?
> 
> This way we can already use them to define thermal zones. Of course,
> that alone won't add the thermal zones. A separated patch would be
> needed to add the thermal zone for OMAP3.

Are you going to add thermal zone defines? If yes, then it would make
sense to add that #thermal line together with thermal zone defines...

-- 
Pali Roh?r
pali.rohar at gmail.com
