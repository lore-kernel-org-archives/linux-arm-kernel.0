From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Fri, 3 Feb 2017 12:25:24 +0000
Subject: [PATCH V7 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <20170203080040.qn53xnpojxzk4qoi@phenom.ffwll.local>
References: <CACvgo535iyFvdOWzQHRnU++Ye0GgyZyN3R9ALSXRP7k3EPyRGA@mail.gmail.com>
 <3e31-58931d80-1-221fa900@101383713>
 <CACvgo50bOZ=jzeJc_J4_7fpiEh9-ATKo1KOhAia2679AGA=mng@mail.gmail.com>
 <20170203080040.qn53xnpojxzk4qoi@phenom.ffwll.local>
Message-ID: <CACvgo53BpgFwr3-LRhe8QpvD3ZRMr7huaRKyp5PTAY6O60J3xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2017 at 08:00, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Feb 02, 2017 at 12:37:21PM +0000, Emil Velikov wrote:
>>  - Daniel, gents - is drm-misc aimed at devs with limited (no?)
>> review/commit history in the area and/or the kernel in general ?
>> In this case, Peter have quite noticeable experience [in kernel
>> development] with little-to no in DRM.
>> Should one draw a line in the sand somewhere ?
>
> We're fairly lenient with accepting new drivers already, and for drivers
> in drm-misc we require some checks and peer review to make sure new folks
> learn faster. But it's an expirement, I fully expect some fallout and then
> some learnign and fine tuning from that, and maybe we even need to crank
> requirements back up to a much higher level of experience.
>
> But for drivers I'm honestly not too concerned: As long as there's some
> process in place to foster learning&collaboration (which I think will be
> better with this) I really don't see much harm in merging non-perfect
> driver code.
>
Thank you Daniel, this is very well said. Being lenient to begin with
and adjusting where/if needed is the more welcoming approach, indeed.
Doubt there'll be (m)any cases of (ab|mis)use but even if so, nobody
can see the future.

>>  - You patch has been on a long [bit rocky road] for a while, with
>> devs giving you [what seems like] a partial reviews.
>> Have you considered reviewing others' patches in exchange for a [more
>> complete one] of this one ? According to git log people have poked you
>> a handful of times, but seemingly you were busy.
>
> Just a clarification: When I review drivers I don't do a fairly cursor
> look, hunting for areas where some refactoring and align with drm best
> practices would be good. And I think that's perfectly fine and enough to
> get a driver landed, but we're definitely not 100% consistent on this
> within drm-misc. Probably will take some time to figure this out.
Seems like I've missed "Peter, your patch..." above, silly me.

Thanks for answering my [what may seem silly] questions ;-)
Emil
