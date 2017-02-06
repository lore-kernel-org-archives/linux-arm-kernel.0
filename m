From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 6 Feb 2017 09:45:45 +0100
Subject: [PATCH V7 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <CACvgo53BpgFwr3-LRhe8QpvD3ZRMr7huaRKyp5PTAY6O60J3xA@mail.gmail.com>
References: <CACvgo535iyFvdOWzQHRnU++Ye0GgyZyN3R9ALSXRP7k3EPyRGA@mail.gmail.com>
 <3e31-58931d80-1-221fa900@101383713>
 <CACvgo50bOZ=jzeJc_J4_7fpiEh9-ATKo1KOhAia2679AGA=mng@mail.gmail.com>
 <20170203080040.qn53xnpojxzk4qoi@phenom.ffwll.local>
 <CACvgo53BpgFwr3-LRhe8QpvD3ZRMr7huaRKyp5PTAY6O60J3xA@mail.gmail.com>
Message-ID: <20170206084545.ke7riv6nacypqw2f@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 12:25:24PM +0000, Emil Velikov wrote:
> On 3 February 2017 at 08:00, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Feb 02, 2017 at 12:37:21PM +0000, Emil Velikov wrote:
> >>  - Daniel, gents - is drm-misc aimed at devs with limited (no?)
> >> review/commit history in the area and/or the kernel in general ?
> >> In this case, Peter have quite noticeable experience [in kernel
> >> development] with little-to no in DRM.
> >> Should one draw a line in the sand somewhere ?
> >
> > We're fairly lenient with accepting new drivers already, and for drivers
> > in drm-misc we require some checks and peer review to make sure new folks
> > learn faster. But it's an expirement, I fully expect some fallout and then
> > some learnign and fine tuning from that, and maybe we even need to crank
> > requirements back up to a much higher level of experience.
> >
> > But for drivers I'm honestly not too concerned: As long as there's some
> > process in place to foster learning&collaboration (which I think will be
> > better with this) I really don't see much harm in merging non-perfect
> > driver code.
> >
> Thank you Daniel, this is very well said. Being lenient to begin with
> and adjusting where/if needed is the more welcoming approach, indeed.
> Doubt there'll be (m)any cases of (ab|mis)use but even if so, nobody
> can see the future.

Yeah, the big idea behind drm-misc is also to make drm more welcoming for
new folks, and I think starting with a small driver or a few driver
patches for hw you have lying around for hacking is a great way. And every
once in a while we can "trick" one of these newbies into doing some cool
core refactoring or cleanup, and maybe even to stick around for a while.

All for world domination and other evil purposes ofc :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
