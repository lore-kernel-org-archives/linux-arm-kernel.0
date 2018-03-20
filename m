From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Mar 2018 19:46:46 +0100
Subject: [PATCH 2/7] dt-bindings: add binding for the Allwinner A64 DE2 bus
In-Reply-To: <20180316175354.21437-3-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-3-icenowy@aosc.io>
Message-ID: <20180320184646.dynqv6qubzabroe4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC to
> be claimed, otherwise the whole DE2 space is inaccessible.
> 
> Add a device tree binding of the DE2 part as a sub-bus.

Where did you get the info that it was a bus?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
