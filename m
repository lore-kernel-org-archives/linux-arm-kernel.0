From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 14:27:02 -0400
Subject: [PATCHv2 2/9] ARM: kirkwood: remove support for legacy booting
 of Dockstar
In-Reply-To: <1375369655-1310-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130803182702.GG13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:07:28PM +0200, Thomas Petazzoni wrote:
> The Kirkwood Dockstar platform has already been converted to the
> Device Tree, so we can remove the legacy booting option for this
> platform.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/Kconfig          |   7 --
>  arch/arm/mach-kirkwood/Makefile         |   1 -
>  arch/arm/mach-kirkwood/dockstar-setup.c | 111 --------------------------------
>  3 files changed, 119 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/dockstar-setup.c

Applied to mvebu/boards

thx,

Jason.
