From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 16:50:44 +0100
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
Message-ID: <20180530155044.GR6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 07:54:47AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 3:37 AM, Mark Brown <broonie@kernel.org> wrote:

> > I'm confused as to why we are specifying the maximum current the device
> > can deliver in a given mode in the DT - surely that's a fixed property
> > of the hardware?

> Said another way: you're saying that you'd expect the "max-microamps"
> table to have one fewer element than the listed modes?  So in the
> above example you'd have:

No, I'm saying that I don't know why that property exists at all.  This
sounds like it's intended to be the amount of current the regulator can
deliver in each mode which is normally a design property of the silicon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/ae2343e4/attachment.sig>
