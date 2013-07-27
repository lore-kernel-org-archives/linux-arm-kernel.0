From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 27 Jul 2013 07:04:08 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAOesGMhEr3DiFm5uSgoHPFUMY4jWu4HkeTU2UmOGj=dS75Vk+g@mail.gmail.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726141016.GF9858@sirena.org.uk>
 <CAOesGMhEr3DiFm5uSgoHPFUMY4jWu4HkeTU2UmOGj=dS75Vk+g@mail.gmail.com>
Message-ID: <20130727050406.GB4221@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 08:49:43AM -0700, Olof Johansson wrote:
> 
> Long term, final goal is likely to be close to what Russell is saying

Why is this a long term goal? Start today.

> -- nothing should go into the kernel tree unless the binding is in a
> fully stable state. However, we have a transitional period between now
> and then, and even when we're at the final state there will be need to
> have some sort of sandbox for development and test of future bindings.

Why not just set up a git tree right away?

> Dealing with all that, as well as the actual process for locking in
> bindings, is what needs to be sorted out.
> 
> I think we're all in agreement that bindings that change over time are
> nothing but pain, but we're arguing that in circles anyway.

No.

I keep saying, the bindings must be stable ABI, *today*.

You keep saying, maybe later, but until then we will make things up as
we go along.

Thanks,
Richard
