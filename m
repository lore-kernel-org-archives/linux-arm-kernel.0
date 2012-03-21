From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Mar 2012 19:07:42 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <4F6A2042.9030302@codeaurora.org>
References: <4F6A2042.9030302@codeaurora.org>
Message-ID: <20120321190741.GL3226@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 11:38:58AM -0700, Saravana Kannan wrote:

> >So it would be interesting to know more about why you (or anyone else)
> >perceive that the Kconfig changes would be harmful.

> But the enthusiasm of the clock driver developers doesn't
> necessarily translate to users of the clock APIs (other driver
> devs). My worry with marking it as experimental in Kconfig and to a
> certain extent in the documentation is that it will discourage the
> driver devs from switching to the new APIs. If no one is using the
> new APIs, then platforms can't switch to the common clock framework

These aren't new APIs, the clock API has been around since forever.
For driver authors working on anything that isn't platform specific the
issue has been that it's not implemented at all on the overwhelming
majority of architectures and those that do all have their own random
implementations with their own random quirks and with no ability for
anything except the platform to even try to do incredibly basic stuff
like register a new clock.

Simply having something, anything, in place even if it's going to churn
is a massive step forward here for people working with clocks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120321/b5747b79/attachment-0001.sig>
