From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 22:26:01 +0800
Subject: [PATCH 1/3] ARM: dts: imx7-colibri: move SD-card to module level
In-Reply-To: <20160829051324.2276-1-stefan@agner.ch>
References: <20160829051324.2276-1-stefan@agner.ch>
Message-ID: <20160829142600.GS30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 10:13:22PM -0700, Stefan Agner wrote:
> Move SD-card definition to module level. While at it, also disable
> write-protect since the Colibri standard does not define a pin for
> SD-Card write-protection.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied all, thanks.
