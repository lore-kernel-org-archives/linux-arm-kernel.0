From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Feb 2017 09:48:09 +0800
Subject: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for zx2967 family
In-Reply-To: <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
 <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
Message-ID: <20170209014807.GO3407@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 06:52:07PM -0600, Rob Herring wrote:
> On Wed, Feb 08, 2017 at 11:02:34AM +0800, Baoyou Xie wrote:
> > ZTE's zx2967 I2S controller driver introduces pclk, this
> > patch documents this fact.
> 
> Now we have the same subject for patches 2 and 3.
> 
> Personally, I'd prefer "dt-bindings: sound: blah...", but not enough to 
> argue with Mark about it. If that is not the prefix, then it should at 
> least have "binding" in the subject.

+1

The prefix of sound bindings is quite unique from other subsystems.
Looking at the prefix of Documentation/devicetree/bindings/sound/
commits, I'm always confused whether it's a pure binding commit
or just submitted as part of the driver patch.  I feel that we
kinda lose the point of having a prefix.

Just my 2 cents.

Shawn
