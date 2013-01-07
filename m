From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 12:48:31 -0500
Subject: [PATCH v2] ARM: kirkwood: convert Guruplug Server Plus to use
 the device tree
In-Reply-To: <20121209184004.GC28052@1wt.eu>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net>
 <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net>
 <20121209184004.GC28052@1wt.eu>
Message-ID: <20130107174831.GN5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 09, 2012 at 07:40:04PM +0100, Willy Tarreau wrote:
> Hi Jason,
> 
> On Sun, Dec 02, 2012 at 06:41:10PM -0500, Jason Cooper wrote:
> > On Mon, Dec 03, 2012 at 12:22:26AM +0100, Willy Tarreau wrote:
> > > Since there are already pending changes for the merge window, I'll
> > > rather resend it after the merge window when the changes are already
> > > done, what do you think ?
> > 
> > Doesn't matter in this case, I'll handle any conflicts.  Please resend
> > when ready.  You can just base off of v3.7-rc7, or v3.8 if it drops.
> 
> OK, I've updated it according to your comments and ensured it still
> works on my GPSP.
> 
> I have based the patch on the ARM tree because it includes some dtsi
> files that are needed by this patch. Please find it attached.
> 
> Best regards,
> Willy
> 

> From 075e116c6cb513af0e0b9d9167ddd47e1b084bca Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sun, 9 Dec 2012 19:21:09 +0100
> Subject: ARM: kirkwood: convert Guruplug Server Plus to device tree
> 
> Add a device tree entry for the Guruplug Server Plus board. This port
> was based both on the work done on the dreamplug and the dockstar.
> 
> It builds, boots and works on my Guruplug Server Plus.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/arm/boot/dts/Makefile                         |  1 +
>  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts | 94 ++++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig                     |  7 ++
>  arch/arm/mach-kirkwood/Makefile                    |  1 +
>  arch/arm/mach-kirkwood/board-dt.c                  |  4 +
>  arch/arm/mach-kirkwood/board-guruplug.c            | 39 +++++++++
>  arch/arm/mach-kirkwood/common.h                    |  5 ++
>  7 files changed, 151 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c

Applied to mvebu/boards.

thx,

Jason.
