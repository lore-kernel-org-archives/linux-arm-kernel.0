From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 25 Jul 2013 20:48:34 +0200
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
Message-ID: <20130725184834.GA8296@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 07:29:20PM +0100, Mark Rutland wrote:
> On Thu, Jul 25, 2013 at 07:05:48PM +0100, Stephen Warren wrote:
> > 
> > I don't think having people "rely" on the bindings is the issue so much
> > as the awareness that if they do, there will be compatibility issues for
> > unstable bindings.
> 
> As long as we can make sufficiently clear that trying to use an unstable
> binding is going to be *very* painful, and not necessarily supported.

Oh, man.

The introduction of DT into ARM Linux was supposed to make everyone's
life sooo much easier. Of course, based on experience with powerpc, I
never believed it*, but still I would expect to hear that the DT
bindings are, well, a *binding* contract between the board developer,
boot loader, and the kernel.

Once it is working with a particular kernel, a DT board description
file should continue to work indefinitely with newer kernels. Anything
less is a regression, pure and simple.

If you go around changing the bindings willy nilly, then what is point
of having DT at all?

Thanks,
Richard

* http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/046963.html
  http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/050255.html
  http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/050256.html
  http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/050264.html
