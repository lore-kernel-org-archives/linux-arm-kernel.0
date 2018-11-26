From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 26 Nov 2018 15:12:41 +0100
Subject: [PATCH 0/9] drm: remove deprecated functions
In-Reply-To: <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
 <20181121094233.GN4266@phenom.ffwll.local>
 <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
Message-ID: <20181126141241.GM4266@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2018 at 10:17:13PM +0100, Linus Walleij wrote:
> On Wed, Nov 21, 2018 at 10:42 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Nov 15, 2018 at 11:38:35PM +0100, Linus Walleij wrote:
> > > On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:
> > >
> > > > One of the things in the DRM TODO list ("Documentation/gpu/todo.rst") was to
> > > > "switch from reference/unreference to get/put". That's what this patch series is
> > > > about.
> > >
> > > The series:
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Since your reviewed it all, and there's a pile of acks for the driver
> > parts too: Want to go ahead and apply it too?
> 
> OK I did... the git was quirky, patches changes around
> under my feet and dim started to complain about problems
> with commits that weren't even mine.
> 
> It was especially scary.
> 
> But I think I managed to apply the patches and push the
> branch now.

Except when you're racing with someone else you should only see conflicts
with stuff you've just pushed. Or if someone forgot to fix up their mess.
What was the conflict? Looking at the git-rerere log I'm not exactly sure
what happened ... Looks like only one of the patches didn't apply cleanly
anymore because it was somewhat outdated. Otherwise nothing from you.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
