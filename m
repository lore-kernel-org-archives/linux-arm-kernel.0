From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Jun 2013 10:18:13 -0400
Subject: [PATCH] ARM: mvebu: set aliases for ethernet controllers
In-Reply-To: <1370278056-3058-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370278056-3058-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130604141813.GE3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 06:47:36PM +0200, Thomas Petazzoni wrote:
> From: Willy Tarreau <w@1wt.eu>
> 
> These aliases are used when feeding the DT from ATAGS to set the
> devices MAC addresses.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi     | 9 +++++++--
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 3 ++-
>  arch/arm/boot/dts/armada-xp.dtsi         | 6 +++++-
>  3 files changed, 14 insertions(+), 4 deletions(-)

Applied to mvebu/dt

thx,

Jason.
