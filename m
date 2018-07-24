From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jul 2018 15:57:55 +0100
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
Message-ID: <20180724145755.GF13268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 01:09:05PM -0700, Doug Anderson wrote:

> I know you are still looking for time to review the RPMh-regulator
> driver and that's fine.  One idea I had though: if the bindings look
> OK to you and are less controversial, is there any chance they could
> land in the meantime?

This appears to have a bunch of dependencies which I've got no idea
what's going on with the merging of and no idea if they'll affect the
bindings or anything, nobody's said anything and last I looked it was
unclear what was going on.  I'm kind of hoping that things might have
sorted themselves out of the merge window.

Some of the decisions in the code have flowed out into the bindings
before so I'm not keen to merge the bindings separately, and if the
driver for the thing used to communicate with the device is still in
review then that's definitely a red flag.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/df661b4c/attachment-0001.sig>
