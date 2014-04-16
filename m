From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Apr 2014 11:18:35 +0300
Subject: [PATCH] ARM: tegra: define Jetson TK1 regulators
In-Reply-To: <CAL1qeaF+Kha6bS27OLoWw-G2Tv6PzeB6=GcK6dM6s_hWidvLiA@mail.gmail.com>
References: <1397516120-18220-1-git-send-email-swarren@wwwdotorg.org>
 <CAL1qeaF+Kha6bS27OLoWw-G2Tv6PzeB6=GcK6dM6s_hWidvLiA@mail.gmail.com>
Message-ID: <20140416081835.GB30476@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:24:42AM +0200, Andrew Bresticker wrote:
> > +                               ldo11 {
> > +                                       regulator-name = "+1.8V_RUN_VPP_FUSE";
> > +                                       regulator-min-microvolt = <1800000>;
> > +                                       regulator-max-microvolt = <1800000>;
> > +                               };
> > +                       };
> >                 };
> >         };
> >
> > @@ -1462,6 +1611,7 @@
> >                 cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
> >                 power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
> >                 bus-width = <4>;
> > +               vmmc-supply = <&vddio_sdmmc3>;
> 
> I don't have schematics for this board, but I suspect you mean
> vqmmc-supply here, per the discussion in the Venice2 VQMMC thread.
> 

Schematics can be found at https://developer.nvidia.com/jetson-tk1-support

Cheers,

Peter.
