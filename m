From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 29 Nov 2014 11:41:02 +0100
Subject: [PATCH] drm: i2c: tda998x: Retry fetching the EDID if it fails
 first time.
In-Reply-To: <54783A2F.5010405@arm.com>
References: <546B84C6.3090809@arm.com> <20141128091905.3e491c39@armhf>
 <54783A2F.5010405@arm.com>
Message-ID: <20141129114102.02366857@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Nov 2014 09:02:39 +0000
Andrew Jackson <Andrew.Jackson@arm.com> wrote:

> > It seems that your patch is deprecated by Laurent Pinchart's
> > 	[PATCH] drm: tda998x: Use drm_do_get_edid()
> > http://lists.freedesktop.org/archives/dri-devel/2014-November/072906.html
> >   
> 
> Thank you for the heads-up, I'd not seen that.  I'll consider how my patch might be modified to suit the new infrastructure.

You don't need any patch: drm_do_get_edid() already loops on reading
the EDID.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
