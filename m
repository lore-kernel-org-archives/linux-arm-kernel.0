From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 11:48:20 -0500
Subject: [PATCH v4 1/2] arm: mvebu: update defconfig with ATAG support
 when using DT
In-Reply-To: <1359998469-28133-2-git-send-email-gregory.clement@free-electrons.com>
References: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
 <1359998469-28133-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130216164820.GB23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 06:21:07PM +0100, Gregory CLEMENT wrote:
> Some of the mvebu boards (mainly the development board) come with
> plug-in RAM modules. This patch allows to let the bootloaders which
> have no support for DTS to give the real amount of memory available on
> the board.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/boards

thx,

Jason.
