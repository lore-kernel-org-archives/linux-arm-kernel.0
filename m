From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 23:21:17 +0000
Subject: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
In-Reply-To: <20140204211638.GA16179@beef>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-3-git-send-email-mporter@linaro.org>
 <20140204172309.GG22609@sirena.org.uk>
 <20140204211638.GA16179@beef>
Message-ID: <20140204232117.GD22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:16:38PM -0500, Matt Porter wrote:
> On Tue, Feb 04, 2014 at 05:23:09PM +0000, Mark Brown wrote:

> > Is this really only a regulator - does the chip have no other functions?

> It's your average multi-function device with other functions as you are
> suspecting.  Buried in the the MFD driver comments is me admitting that
> I need to split this into two bindings. The base device, "bcm59056" and
> then "bcm59056-reg". So point noted, I'll updated with the appropriate
> binding for each.

It doesn't need to be two bindings - just move it to the MFD section and
document it there.  The existing binding is totally fine from a
regulator standpoint and should continue to be so as other functions are
added.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/638d2eb9/attachment.sig>
