From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 11:17:39 -0500
Subject: [PATCH V4 05/11] ARM: kirkwood: nsa310: convert to pinctrl
In-Reply-To: <655862a52c4f90a3f90a566824b495c2017c3c5b.1359232975.git.jason@lakedaemon.net>
References: <cover.1359232975.git.jason@lakedaemon.net>
 <655862a52c4f90a3f90a566824b495c2017c3c5b.1359232975.git.jason@lakedaemon.net>
Message-ID: <20130216161739.GY14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 08:50:14PM +0000, Jason Cooper wrote:
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/boot/dts/kirkwood-nsa310.dts | 99 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-dt.c     |  3 --
>  arch/arm/mach-kirkwood/board-nsa310.c | 26 ---------
>  arch/arm/mach-kirkwood/common.h       |  6 ---
>  4 files changed, 99 insertions(+), 35 deletions(-)

Applied to mvebu/dt

thx,

Jason.
