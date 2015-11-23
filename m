From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Nov 2015 00:38:59 +0100
Subject: [PATCH 0/4] Component helper updates
In-Reply-To: <20151123160210.GR8644@n2100.arm.linux.org.uk>
References: <20151123160210.GR8644@n2100.arm.linux.org.uk>
Message-ID: <20151123233859.GC22339@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:02:11PM +0000, Russell King - ARM Linux wrote:
> Greg,
> 
> These four patches update the component helper by:

Hi Russell

Is there any documentation for the component helper, in particular,
when devm_ can be used?

It seems like slaves should only do a component_add() in their probe
function, and then do resource allocation using devm_* in the bind
callback?

It seems like a master device can however use devm_ in its probe
function?

Thanks
	Andrew
