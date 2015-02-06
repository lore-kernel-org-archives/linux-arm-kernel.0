From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 6 Feb 2015 11:50:00 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <54D491F3.9060004@gmail.com>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
 <54CB6440.1010002@gmail.com> <20150130124144.501cf81d@armhf>
 <54CB732F.7010409@gmail.com> <20150130133913.083d1ade@armhf>
 <54CB7E33.3080909@gmail.com> <54CE354F.5090106@gmail.com>
 <54D3EB26.9020909@gmail.com> <20150206085855.7b8d494b@armhf>
 <54D491F3.9060004@gmail.com>
Message-ID: <20150206115000.700aa8d5@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 Feb 2015 11:05:39 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> >> We do have a driver for the framebuffer (armada_drm) and there is great
> >> work from Russell King and others on the GPU and Decode engine (IIRC).  
> >
> > Yes, but it has no DT support. Mine has.  
> 
> Yeah, it would be nice if you two stick together once again and work
> that out for mainline?

It is not important for me to have something in the mainline: my driver
works fine enough for program development, and I don't need video
streaming. On the other hand, Russell said that his system does not
work well in a DT context...

> > Actually, as Gabriel told me that his screen is directly connected to
> > the RGB LCD output, I wrote a simple panel for him. This module just
> > gets the display timings from the DT.  
> 
> Ok. That makes it less complicated as there already should be support
> for dumb RGB anyway.

I could not find such a module, and, more, these LCD / VGA modules have
to be componentized to work with the armada DRM driver, and same for
mine.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
