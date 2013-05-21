From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 21 May 2013 08:30:31 +0200
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <CADnq5_O8nLi1=HOrXO0AeQuX17tGj05fhao4mmauzZ5h8Ciyaw@mail.gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
 <20130517194023.0c385ea0@armhf>
 <20130519085920.GO18614@n2100.arm.linux.org.uk>
 <CADnq5_Pajy4jxLdd9QGBrUooWYFjfQRQgdbvbu9UDE8-7Tmm8g@mail.gmail.com>
 <20130520201536.GY18614@n2100.arm.linux.org.uk>
 <CADnq5_O8nLi1=HOrXO0AeQuX17tGj05fhao4mmauzZ5h8Ciyaw@mail.gmail.com>
Message-ID: <20130521083031.48f1e43e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 May 2013 16:23:33 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> > Note also that the generic DRM KMS code assumes cursor support at
> > 64x64, and there's no generic way for a driver at present (that I know
> > of) to inform it of anything different.  
> 
> It shouldn't be too hard to add a new cap for querying the cursor size
> to the drm cap interface.

There was already a patch request for that, but the functions were
surely useless.

Otherwise, you may do a search on "largest cursor:" (xdpyinfo output).
The results are surprising..

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
