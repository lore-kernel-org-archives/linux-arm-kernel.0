From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Jun 2018 16:01:26 +0100
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
 <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
Message-ID: <20180627150126.GC5263@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 11:15:14AM -0700, Doug Anderson wrote:

> I think he's still planning on re-shuffling his tree a bit.  When he
> does this, do you need him to put the RPMh patches somewhere you can
> merge into your tree?

Well, I *think* there's no actual dependency here since it's a new
driver with a Kconfig dependency.  It really just needs me to get round
to trawling through what's a fairly large patch with a troubled history
now you've reviewed it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/813bc040/attachment.sig>
