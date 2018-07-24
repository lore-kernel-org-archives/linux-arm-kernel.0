From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jul 2018 16:25:14 +0100
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
Message-ID: <20180724152514.GJ13268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 08:11:30AM -0700, Doug Anderson wrote:

> RPMh itself landed in Andy's tree and he sent a pull request on
> Saturday.  Feel free to refer to the request ("[GIT PULL] Qualcomm
> Driver updates for 4.19") AKA
> <https://patchwork.kernel.org/patch/10539125/>.

> It doesn't look like arm-soc has picked up Andy's pull request yet
> though.  If having it in arm-soc is a requirement then I'm happy to
> monitor arm-soc and ping this thread again when it's there.

There was also some other thing called command DB as well which was a
separate series.  Ideally there'd be a branch I could pull as there's a
build dependency on rpmh so I can't apply until the code has landed in
my tree, don't know what command DB is exactly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/a46a2fc2/attachment.sig>
