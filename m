From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 22 Nov 2018 09:55:49 +0100
Subject: [PATCH 0/9] drm: remove deprecated functions
In-Reply-To: <22044302.7aKok9czXB@avalon>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
 <20181121094233.GN4266@phenom.ffwll.local>
 <22044302.7aKok9czXB@avalon>
Message-ID: <20181122085549.GX4266@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 08:21:29PM +0200, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Wednesday, 21 November 2018 11:42:33 EET Daniel Vetter wrote:
> > On Thu, Nov 15, 2018 at 11:38:35PM +0100, Linus Walleij wrote:
> > > On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos wrote:
> > >> One of the things in the DRM TODO list ("Documentation/gpu/todo.rst")
> > >> was to "switch from reference/unreference to get/put". That's what this
> > >> patch series is about.
> > > 
> > > The series:
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Since your reviewed it all, and there's a pile of acks for the driver
> > parts too: Want to go ahead and apply it too?
> 
> Please remember to give at least a week to reviewers, especially with LPC last 
> week.

I think for this undisputed cocci series waiting for everyone is not
needed. There's really not much the driver-specific reviewer perspective
would help here.

In general I do agree though, if there's something driver maintainers can
have better insight on.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
