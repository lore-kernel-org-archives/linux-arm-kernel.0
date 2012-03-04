From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:59:01 -0800
Subject: What's in tegra.git for 3.4
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BCF6A@HQMAIL01.nvidia.com>
References: <CAOesGMjnWPgSa44hgRu+d0jrQLm9KuOcuufg9V8fYZ8TytsbPw@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BCF6A@HQMAIL01.nvidia.com>
Message-ID: <20120304185901.GI31064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 09:41:56AM -0800, Stephen Warren wrote:
> Olof Johansson wrote at Sunday, February 26, 2012 3:51 PM:
> > We're closing in on when things need to be in the sub-arch trees in
> > time to get merged for the next merge window. The shortlog below is
> > what i have queued up today.
> 
> The following are in patchwork and should probably be picked up:

Btw, patchwork is down, so I had to guess which patches were being referred to.
While it's convenient to have the links, also having the patch subject would be
good. :-)


> http://patchwork.ozlabs.org/patch/139197/
> http://patchwork.ozlabs.org/patch/142663/ (should be merged elsewhere?)

Applied x2.

> 
> Are these still relevant?
> http://patchwork.ozlabs.org/patch/132936/

I'll revisit this one later -- one of the drivers is buggy and causes problems
on boot.

> http://patchwork.ozlabs.org/patch/132919/

This is already in mainline

> Should you ping Dmitry on?
> http://patchwork.ozlabs.org/patch/134093/

Pinged repeatedly, no answers.

> I need to ping Ben on:
> http://patchwork.ozlabs.org/patch/139494/

Yeah, we can take it through tegra if needed, we've done it in the past.


-Olof
