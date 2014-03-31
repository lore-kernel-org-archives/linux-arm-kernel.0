From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 31 Mar 2014 10:26:13 -0700
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CAOesGMh7AFfuq73SxOWiiLV0eJNLpA0M5hr0OwRo8=BLWueWwQ@mail.gmail.com>
References: <20140328184517.GA27219@cbox>
 <CAOesGMh7AFfuq73SxOWiiLV0eJNLpA0M5hr0OwRo8=BLWueWwQ@mail.gmail.com>
Message-ID: <20140331172613.GA4756@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 30, 2014 at 03:10:50PM -0700, Olof Johansson wrote:
> On Fri, Mar 28, 2014 at 11:45 AM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > ARM VM System Specification
> > ===========================
> 
> [not quoting the whole spec here]
> 
> This looks very sane to me, and aligns very well with non-virtualized images.
> 
> For what it's worth, even though it's not a patch:
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks, appreciate it.

> 
> What's the plan on how to lock this in? Where's this document going to
> live? In the kernel sources under Documentation/, or external?
> 

There were talks during LCA14 about publishing it as a Linaro
white-paper, but I would like it to be hosted by the open-source
projects that relate to it, for example the Linux kernel under
Documentaiton/ to represent both the guest and KVM side, and the Xen
sources too.

However, that may be a pain to update so the preferred method could be
to host it in either its current form (clear-text) or publish some
versioned PDF somewhere and simply point to it from the compliant
software pieces.

Suggestions or input welcome.

-Christoffer
