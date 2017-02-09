From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Feb 2017 12:06:25 +0000
Subject: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for zx2967 family
In-Reply-To: <20170209014807.GO3407@dragon>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
 <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
 <20170209014807.GO3407@dragon>
Message-ID: <20170209120625.lhqcistgyjpy3plq@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 09:48:09AM +0800, Shawn Guo wrote:
> On Wed, Feb 08, 2017 at 06:52:07PM -0600, Rob Herring wrote:

> > Personally, I'd prefer "dt-bindings: sound: blah...", but not enough to 
> > argue with Mark about it. If that is not the prefix, then it should at 
> > least have "binding" in the subject.

> +1

> The prefix of sound bindings is quite unique from other subsystems.
> Looking at the prefix of Documentation/devicetree/bindings/sound/
> commits, I'm always confused whether it's a pure binding commit
> or just submitted as part of the driver patch.  I feel that we
> kinda lose the point of having a prefix.

That's really not what's happening reliably - other subsystems also seem
to have a bunch of things prefixed for the subsystem and the DT specific
prefixes are all over the shop, people seem to be making them up at
random.  If DT binding review were something that reliably and
consistently happened and didn't affect the subsystem I'd perhaps buy it
but for run of the mill stuff it seems like getting things reviewed in
the subsystem is more important.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/5975fa67/attachment.sig>
