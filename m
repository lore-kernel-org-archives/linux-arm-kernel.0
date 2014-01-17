From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 Jan 2014 18:27:08 +0100
Subject: [PATCH v2 13/28] drm/i2c: tda998x: use irq for connection
 status and EDID read
In-Reply-To: <52D2EC5D.2010800@gmail.com>
References: <20140109120412.7697d23c@armhf>
 <20140111181432.GB15937@n2100.arm.linux.org.uk>
 <52D18EE9.5030305@gmail.com> <20140112195113.316d0c98@armhf>
 <52D2EC5D.2010800@gmail.com>
Message-ID: <20140117182708.3758acb1@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jan 2014 20:26:21 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 01/12/2014 07:51 PM, Jean-Francois Moine wrote:
> > On Sat, 11 Jan 2014 19:35:21 +0100
> > Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> >
> >> At least for the DT part, I'd suggest to not ask for interrupt directly
> >> but use a proper gpios property. The can of course be converted to
> >> priv->int_irq in some tda998x_dt_probe.
> >
> > May you give me more information?
> 
> Sure, see [1].
> 
> [1] http://lists.freedesktop.org/archives/dri-devel/2013-May/038822.html

Thanks for the link, but I still don't see the advantage of the gpio
(which value?) over the irq number.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
