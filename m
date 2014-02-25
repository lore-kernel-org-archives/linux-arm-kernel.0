From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 15:16:29 -0500
Subject: [PATCH] ARM: kirkwood: select dtbs based on SoC
In-Reply-To: <1393350954-18767-1-git-send-email-jason@lakedaemon.net>
References: <1393350954-18767-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20140225201629.GC1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 05:55:54PM +0000, Jason Cooper wrote:
> To prevent problems later with mvebu_v5_defconfig builds, we restrict
> the scope of the changes this series makes.
> 
> Selecting ARCH_KIRKWOOD and MACH_KIRKWOOD is necessary during the
> migration from mach-kirkwood to mach-mvebu.  Until the last four legacy
> kirkwood board files have a DT equivalent, we need to support building
> DT from both mach-kirkwood and mach-mvebu.
> 
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> If there are no complaints, I'll be applying this on top of Andrew's kirkwood
> migration series in mvebu/soc-kw
> 
>  arch/arm/boot/dts/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/soc-kw with Kevin's Ack.

thx,

Jason.
