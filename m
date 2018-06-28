From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Jun 2018 11:18:13 +0100
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
 <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
 <20180627150126.GC5263@sirena.org.uk>
 <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
Message-ID: <20180628101813.GD14040@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 09:28:03AM -0700, Doug Anderson wrote:

> OK, great.  I guess I'm confused about the "|| COMPILE_TEST" causing
> problems then?  I was worried that anyone trying to do "COMPILE_TEST"
> on your tree (or linuxnext if RPMh isn't there) would get failures due
> to the lack of header files.  I guess if it's a problem you could just
> gut the "|| COMPILE_TEST" and it could be added back in later?

Ugh, yes - that'll break things.  In that case I can't apply this
without a signed tag from Andy's tree with the dependency stuff in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180628/f43b7989/attachment.sig>
