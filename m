From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Feb 2016 08:37:02 -0600
Subject: [PATCH 3/6] ASoC: rockchip: add bindings for rk3399 i2s
In-Reply-To: <20160217110306.GJ7544@sirena.org.uk>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
 <1455673992-16469-4-git-send-email-jay.xu@rock-chips.com>
 <20160217110306.GJ7544@sirena.org.uk>
Message-ID: <20160218143702.GN9654@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 11:03:06AM +0000, Mark Brown wrote:
> On Wed, Feb 17, 2016 at 09:53:09AM +0800, jianqun.xu wrote:
> 
> > ---
> >  Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> As with the other patch I'd expect to see a matching driver update if
> only for documentation purposes.

Why? They match on the prior chip's compatible until there is some 
difference the driver needs to handle.

Rob
