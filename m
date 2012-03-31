From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 30 Mar 2012 21:30:06 -0400
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <1332885255-8304-2-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-2-git-send-email-jm@lentin.co.uk>
Message-ID: <20120331013006.GH7274@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 10:54:11PM +0100, Jamie Lentin wrote:
> Add support for the DNS-320 and DNS-325. Describe as much as currently possible
> in the devicetree files, create a board-dnskw.c for everything else.
> 
> Use IEEE-compliant "okay", rather than "ok"
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  arch/arm/boot/dts/kirkwood-dns320.dts |   29 +++
>  arch/arm/boot/dts/kirkwood-dns325.dts |   24 +++
>  arch/arm/mach-kirkwood/Kconfig        |   23 +++
>  arch/arm/mach-kirkwood/Makefile       |    1 +
>  arch/arm/mach-kirkwood/Makefile.boot  |    2 +
>  arch/arm/mach-kirkwood/board-dnskw.c  |  306 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-dt.c     |    5 +
>  arch/arm/mach-kirkwood/common.h       |    6 +
>  8 files changed, 396 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

Jamie,

I've applied this locally, thanks.  Looks like Grant took #5 through his
tree.  As #3 and #4 depend on #2, I'll wait for the next version of #2
incorporating Grant's comments before I apply #2-#4.

thx,

Jason.
