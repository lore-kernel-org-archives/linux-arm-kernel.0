From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 23 Mar 2011 10:31:57 +0100
Subject: Updated mach-types update
In-Reply-To: <20110322193026.GC17264@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<AANLkTi=C3TGRvN+eWLc+C2JHf_XRmc_s8Dp+pnGkO+j2@mail.gmail.com>
	<20110322193026.GC17264@n2100.arm.linux.org.uk>
Message-ID: <20110323093157.GA6397@vixen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 22, 2011 at 07:30:26PM +0000, ext Russell King - ARM Linux wrote:
> On Tue, Mar 22, 2011 at 02:19:11PM +0100, Domenico Andreoli wrote:
> > On Sun, Mar 20, 2011 at 12:03 PM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > >
> > > What this means is that any platform in the machine database which has not
> > > been submitted to mainline for 12 months since it was registered will be
> > > automatically dropped from the file, and the platform maintainer will need
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > to either talk to me to get it reinstated before submission, or update the
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > entry in some way to 'freshen' it.
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > 
> > I think this statement matches the needs of those, like me, are trying to
> > add a new board.
> > My patch [0] applies but does not build any more. How does it work in this
> > case?
> 
> Precisely in the way I said above - see the bit I've underlined.

So it looks like I cannot be of any help improving my QQ2440 patch :)

Could you please reintroduce the qq2440 mach type? I have one patch
[0] sitting, I got some feedback but nobody has Revieved-by the v3 yet.
The networking part has been already pulled by Linus trough netdev.

Thank you.

> > anyway I would add some comment in mach-types that explains how the files is
> > managed.
> 
> You mean like the comment that's in there - have you even looked at the
> cut down version yet?

Yes, after I sent the email. It took a while for me to find your git
tree, it was not obvious that rmk is you :) Sorry for the noise.

Regards,
Domenico

[0] http://article.gmane.org/gmane.linux.ports.arm.kernel/110583/match=qq2440
