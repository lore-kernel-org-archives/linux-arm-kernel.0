From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Aug 2018 00:55:06 +0100
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=VJN4vj9eU7wzPV8=WC_+MgRPYx1smF+FUmfDiP3uuTqw@mail.gmail.com>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
 <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
 <20180724165942.GP13268@sirena.org.uk>
 <20180726183922.GA4402@hector.mosconeconnections.com>
 <CAD=FV=VJN4vj9eU7wzPV8=WC_+MgRPYx1smF+FUmfDiP3uuTqw@mail.gmail.com>
Message-ID: <20180806235506.GU2414@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 03:55:53PM -0700, Doug Anderson wrote:
> On Thu, Jul 26, 2018 at 11:39 AM, Andy Gross <andy.gross@linaro.org> wrote:

> > The arm-soc guys merged the Qualcomm pull requests.  So you can just use my
> > qcom-drivers-for-4.19 tag.  That won't change at this point.

> > git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
> > qcom-drivers-for-4.19

> Did Andy's idea of using the above tag work for you?  It appears that
> there are a few patches you don't need there, but it shouldn't hurt to
> pick them up too I think?  Here's what I see:

It does make my pull request look larger which is hard to get enthused
about.

> a3134fb09e0b drivers: soc: Add LLCC driver

Stuff like this jumped out for example.

> It seems like it's too late to land RPMh-regulator for 4.19, so I
> guess we'll have to aim for 4.20.  I'm not sure if that means you're
> going to want to wait until 4.20-rc1 comes out to use as a base before
> thinking about landing RPMh-regulator?  If so then I guess we've got

If I apply it after the merge window it's going to be based on -rc1.  If
I get to it this week I guess I'll have to pull in the drivers tag.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180807/529ed762/attachment.sig>
