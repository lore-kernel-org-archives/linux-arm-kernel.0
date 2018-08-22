From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 22 Aug 2018 22:12:26 +0200
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180814084112.GE21634@phenom.ffwll.local>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812195536.GA29811@ravnborg.org>
 <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
 <20180814084112.GE21634@phenom.ffwll.local>
Message-ID: <20180822201226.GB22148@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel.

> > > Based on the above, would it be possible to utilise some
> > > of these features without any dedicated userspace (mesa) support?
> > > Any other driver that has something similar that can be used
> > > for inspiration?
> > 
> > This is really an interesting question indeed.
> 
> Needs userspace like everything else. There's unfortunately no real
> standard for 2d apis in userspace, which means none of these efforts go
> very far. Mostly it's just some custom-made X drivers.
> 
> Adding a generic 2d api to drm is a FAQ, and the answer is "no".

And then you went off writing a blog post about it - thanks.
The blog post provided a lot of useful answers - great.

(Or rather you will write the blog in 5 days, seems to be some time
 machine involved. (Date is the 27th below the title)).

	Sam
