From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 8 Nov 2014 01:38:41 +0100
Subject: [PATCH v4 10/10] [media] v4l: Forbid usage of V4L2_MBUS_FMT
 definitions inside the kernel
In-Reply-To: <545D4BFD.6000206@iki.fi>
References: <545CDB8D.4080406@xs4all.nl>
 <1415377630-16564-1-git-send-email-boris.brezillon@free-electrons.com>
 <545D4BFD.6000206@iki.fi>
Message-ID: <20141108013841.1f3f1bc2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 08 Nov 2014 00:47:25 +0200
Sakari Ailus <sakari.ailus@iki.fi> wrote:

> Hi Boris,
> 
> Boris Brezillon wrote:
> > @@ -102,6 +113,7 @@ enum v4l2_mbus_pixelcode {
> >  
> >  	V4L2_MBUS_FROM_MEDIA_BUS_FMT(AHSV8888_1X32),
> >  };
> > +#endif /* __KERNEL__ */
> >  
> >  /**
> >   * struct v4l2_mbus_framefmt - frame format on the media bus
> 
> Was it intended to be this way, or did I miss something? I'd put this to
> beginning of the file, as Hans suggested.

Oops, I forgot to move the struct.

> 
> With this matter sorted out, for the set:
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
