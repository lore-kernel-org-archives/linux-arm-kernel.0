From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Feb 2016 14:59:54 +0000
Subject: [PATCH 3/6] ASoC: rockchip: add bindings for rk3399 i2s
In-Reply-To: <20160218143702.GN9654@rob-hp-laptop>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
 <1455673992-16469-4-git-send-email-jay.xu@rock-chips.com>
 <20160217110306.GJ7544@sirena.org.uk>
 <20160218143702.GN9654@rob-hp-laptop>
Message-ID: <20160218145954.GI7129@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 08:37:02AM -0600, Rob Herring wrote:
> On Wed, Feb 17, 2016 at 11:03:06AM +0000, Mark Brown wrote:

> > As with the other patch I'd expect to see a matching driver update if
> > only for documentation purposes.

> Why? They match on the prior chip's compatible until there is some 
> difference the driver needs to handle.

That then requires anyone using a compatible string to also know the
full set of other compatible strings that can be used for this device
and that they have to list the others too in the correct order which
isn't something the binding document tells them.  It also feels better
to record in the code how we think we should support the device when we
know it, seems more helpful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/3903df38/attachment.sig>
