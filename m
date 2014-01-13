From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 13 Jan 2014 10:26:24 +0100
Subject: [PATCH v2 23/28] drm/i2c: tda998x: add the active aspect in
 HDMI AVI frame
In-Reply-To: <20140111185114.GK15937@n2100.arm.linux.org.uk>
References: <20140109120639.5f76c620@armhf>
 <20140111185114.GK15937@n2100.arm.linux.org.uk>
Message-ID: <20140113102624.04d270ce@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jan 2014 18:51:14 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Jan 09, 2014 at 12:06:39PM +0100, Jean-Francois Moine wrote:
> > This patch adds the active aspect as 'picture' in the HDMI AVI frame
> > and also some comments about this frame.
> 
> Yes, this should've been set.  It's probably a stable tree candidate,
> but first it needs testing.

I get correct 4:3 (1280x960) and 5:4 (1280x1024) images on my 16:9 TV
screen with this aspect value. 16:10 (1680x1050) images are stretched.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
