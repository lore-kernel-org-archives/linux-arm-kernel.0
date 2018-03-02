From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 2 Mar 2018 14:50:00 +0100
Subject: [PATCH] arm: dts: kirkwood: fix error in #sound-dai-cells size
In-Reply-To: <20180301202537.30571-5-robh@kernel.org>
References: <20180301202537.30571-5-robh@kernel.org>
Message-ID: <20180302135000.GD19566@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 02:25:37PM -0600, Rob Herring wrote:
> dtc now gives the following warning:
> 
> arch/arm/boot/dts/kirkwood-t5325.dtb: Warning (sound_dai_property): /sound/simple-audio-card,cpu:sound-dai: property size (4) too small for cell size 1
> 
> The binding documentation gives no indication what the cell size should
> be (which should be fixed too), so just assume 0 is fine as that is what
> the consumer has.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
