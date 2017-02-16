From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Thu, 16 Feb 2017 16:54:45 +0000
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
Message-ID: <CACvgo51p+aqegjkbF6jGggwr+KXq_71w0VFzJvFAF6_egT1-kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2017 at 12:43, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> Hello,
>
> I was wondering about the following. Wasn't there some strict
> requirement about code going upstream, which also included that there
> was a full open-source driver stack for it?
>
> I don't see how this is the case for Mali, neither in the kernel, nor in
> userspace. I'm aware that the Mali kernel driver is open-source. But it
> is not upstream, maintained out of tree, and won't land upstream in its
> current form (no resemblence to a DRM driver at all). And let's not talk
> about the userspace part.
>
> So, why should this be here?
>
Have to agree with Tobias, here.

I can see the annoyance that Maxime and others have to go through to
their systems working.
At the same time, changing upstream kernel to suit out of tree
module(s) is not how things work. Right ?

Not to mention that the series adds stable ABI exclusively(?) used by
a module which does not seem to be in the process of getting merged.

Maxime, you're a great guy but I don't think this is suitable for
upstream... yet.

Regards,
Emil
