From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jul 2018 17:59:42 +0100
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
 <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
Message-ID: <20180724165942.GP13268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 08:43:46AM -0700, Doug Anderson wrote:
> On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:

> > There was also some other thing called command DB as well which was a
> > separate series.  Ideally there'd be a branch I could pull as there's a
> > build dependency on rpmh so I can't apply until the code has landed in
> > my tree, don't know what command DB is exactly.

> Yup.  That one landed in May and is already in mainline Linux.  Refer
> to commit 312416d9171a ("drivers: qcom: add command DB driver").

That's good at least - the cover letter said it was still under review,
guess it just hadn't been updated.

> Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
> can provide you with the branch.

Andy?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/5bad8cf7/attachment.sig>
