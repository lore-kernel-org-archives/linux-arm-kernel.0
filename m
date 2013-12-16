From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 16 Dec 2013 17:25:42 +0400
Subject: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
In-Reply-To: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
References: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <52AEFF56.5010602@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-12-2013 4:31, Simon Horman wrote:

> The koelsch board uses has an SH ethernet controller which uses a Micrel
> phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
> Micrel-specific phy driver rather than relying on the generic phy driver.

    Frankly speaking, I'm seeing no advantages to doing that.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

    Analogous changes are needed for BOCK-W and Lager boards since they all 
use the same KSZ8041RNLI PHY chip. I was going to submit such changes with the 
PHY IRQ patches but since no IRQ is generated still, this got delayed...

WBR, Sergei
