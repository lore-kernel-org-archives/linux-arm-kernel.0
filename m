From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 May 2013 20:42:37 -0400
Subject: [PATCH V2 10/10] ARM: Kirkwood: add DT support for Sheevaplug
 and Sheevaplug eSATA
In-Reply-To: <1368479941-10084-11-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-11-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130515004237.GJ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 11:19:01PM +0200, Simon Baatz wrote:
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  arch/arm/mach-kirkwood/Kconfig            |    7 +++++++
>  arch/arm/mach-kirkwood/Makefile           |    1 +
>  arch/arm/mach-kirkwood/board-dt.c         |    4 ++++
>  arch/arm/mach-kirkwood/board-sheevaplug.c |   27 +++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.h           |    5 +++++
>  5 files changed, 44 insertions(+)
>  create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c

Applied to mvebu/boards

thx,

Jason.
