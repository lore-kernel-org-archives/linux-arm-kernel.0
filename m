From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Mon, 23 Aug 2010 18:50:43 +0300
Subject: Policy question: criteria for submission to mainline for a new
	SoC?
In-Reply-To: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
References: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
Message-ID: <AANLkTimpZg_CE9FmNs+H7+dEZdPhMg63=VOgPzWFfn1a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 6:20 PM, Jason McMullan
<jason.mcmullan@netronome.com> wrote:
>
> However, I am not sure if it is worth cluttering up the Linux ARM
> arch mainline with yet another rare SoC. If the Linux ARM community
> would like the sources, I am more than willing to post them on
> the list, but there's not much new or interesting to see - just
> a lot of trivial SoC hardware details.

Don't think of it as cluttering up. The Linux kernel changes so fast
that by pushing code into mainline, you'll offload some of the more
mundane maintenance tasks over to the kernel developers. So you won't
have to track internal API changes when you rebase your internal git
tree to the latest version of the Linux kernel.

This is not to say that you can simply email those patches to LAKML
and assume your job is done. It might have to be refactored to suit
the style of code in the kernel. But in the end you'll benefit from
better quality code and probably even code reduction.

> So, the questions are:
>
> A) Is anyone interested in the NFP3200 SoC patches?

Yes, it also makes the Linux kernel better by allowing subsystems to
be designed/refactored to take into account various needs.

> B) What is the general policy for '# of units sold' for whether
> ? a SoC should be added to the Linux ARM mainline?

Even a single board shipped is enough :) See this informative talk by
Greg KH (http://www.kroah.com/log/linux/ols_2006_keynote.html)

Cheers,
Amit
