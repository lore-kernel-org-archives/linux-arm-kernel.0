From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 27 Jul 2013 06:57:24 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <51F2A57D.1090704@gmail.com>
References: <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726141016.GF9858@sirena.org.uk>
 <CAOesGMhEr3DiFm5uSgoHPFUMY4jWu4HkeTU2UmOGj=dS75Vk+g@mail.gmail.com>
 <51F2A57D.1090704@gmail.com>
Message-ID: <20130727045723.GA4221@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 11:36:13AM -0500, Rob Herring wrote:
> On 07/26/2013 10:49 AM, Olof Johansson wrote:
> > On Fri, Jul 26, 2013 at 7:10 AM, Mark Brown <broonie@kernel.org> wrote:
> >> On Fri, Jul 26, 2013 at 03:09:29PM +0200, Richard Cochran wrote:
> >>
> >>> Unless I totally misunderstood, the thread is talking about letting
> >>> established bindings change with each new kernel version.  I am
> >>> opposed to that.
> >>
> >> No, nobody is really saying that is a particularly good idea.  There is
> >> some debate about how we work out what an established binding is but
> >> there's no serious suggestion that we don't want stable bindings.
> > 
> > Yes, what Mark said -- _today_ all bindings are subject to change and
> > can be changed in lockstep with the kernel. This has been necessary as
> > part of development to sort out all of the various bootstrapping
> > issues across platforms.

This statement is an incredible piece of doublespeak. "Of course we
want stable bindings. That is why 'all bindings are subject to change
and can be changed in lockstep with the kernel.'"

If you want to get away from the DT churn, then you have got to tell
people in no uncertain terms that bindings in a released kernel are a
stable ABI and must be supported into the future.

If you need a playground for new ideas, refactoring platforms, etc,
then go right ahead and create one, but please don't do this with
released kernels.

> This is absolutely not true on a global basis. Any binding used on
> powerpc or sparc is not subject to change. Furthermore, there are ARM
> platforms such as highbank where the bindings are expected to be stable.
> That's not saying they don't change (new properties for SATA just
> today), but they only change in a backwards compatible way.

Right, and lets hope the arm tree can also take this stand.

Thanks,
Richard
