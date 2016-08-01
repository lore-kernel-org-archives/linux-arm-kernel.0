From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Aug 2016 08:58:15 +0200
Subject: [PATCH 3/3] ehci-platform: add the max clock number to 4
In-Reply-To: <20160731112536.4625-3-icenowy@aosc.xyz>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
 <20160731112536.4625-3-icenowy@aosc.xyz>
Message-ID: <2477355.hXm3xYUusy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 31, 2016 7:25:36 PM CEST Icenowy Zheng wrote:
> Allwinner A64 EHCI requires 4 clocks to be enabled.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> 

Can you say what those four clocks are?

Are you sure that it's not just a case of a clock being
incorrectly described in the clk driver, i.e. you reference
one clock along with its parent here?

	Arnd
