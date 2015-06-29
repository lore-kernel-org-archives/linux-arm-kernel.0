From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Jun 2015 15:43:43 +0200
Subject: [PATCH v2 2/2] ARM: dts: add buffalo linkstation ls-wvl/vl
In-Reply-To: <559146B0.1010905@free-electrons.com>
References: <1434713319-8691-3-git-send-email-rogershimizu@gmail.com>
 <1434985351-6678-1-git-send-email-rogershimizu@gmail.com>
 <559146B0.1010905@free-electrons.com>
Message-ID: <20150629134343.GB4535@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 03:22:56PM +0200, Gregory CLEMENT wrote:
> Hi Roger,
> 
> On 22/06/2015 17:02, Roger Shimizu wrote:
> > Add dts file to support Buffalo Linkstation LS-WVL and LS-VL,
> > which are 3.5" HDD NAS in 2-bay and 1-bay respectively.
> > 
> > Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> > Reviewed-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> it seems that you addressed Andrew's remarks too, so
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> 
> However I will wait for Andrew's formal acked-by before applying it.

Hi Gregory

One minor nit pick. Maybe you can fix it while committing?

> > +			pmx_led_alarm: pmx-led-alarm {
> > +				marvell,pins = "mpp36";
> > +				marvell,function = "gpio";
> > +			};
> > +			pmx_led_function_red: pmx-led-function_red {

Second _red should be -red.

> > +				marvell,pins = "mpp37";
> > +				marvell,function = "gpio";
> > +			};

Other than that,

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Thanks
		Andrew
