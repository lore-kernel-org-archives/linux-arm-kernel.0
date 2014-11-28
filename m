From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 28 Nov 2014 09:19:05 +0100
Subject: [PATCH] drm: i2c: tda998x: Retry fetching the EDID if it fails
 first time.
In-Reply-To: <546B84C6.3090809@arm.com>
References: <546B84C6.3090809@arm.com>
Message-ID: <20141128091905.3e491c39@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Nov 2014 17:41:26 +0000
Andrew Jackson <Andrew.Jackson@arm.com> wrote:

> Fetching the EDID from a connected monitor is an automated thing
> with NXP TDA19988. But on some boards the fetching fails for the
> first time silently without any indication that an error has occured.
> More than that, subsequent fetches of the EDID succeed until the
> monitor(s) are unplugged.
> 
> Add a function to validate the read EDID and retry if the block
> retrieved is not valid.
> 
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

It seems that your patch is deprecated by Laurent Pinchart's
	[PATCH] drm: tda998x: Use drm_do_get_edid()
http://lists.freedesktop.org/archives/dri-devel/2014-November/072906.html

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
