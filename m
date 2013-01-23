From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 10:06:15 -0500
Subject: [PATCH 3.8-rc] arm: mvebu: i2c come back in defconfig
In-Reply-To: <1358953079-1277-2-git-send-email-gregory.clement@free-electrons.com>
References: <1358953079-1277-1-git-send-email-gregory.clement@free-electrons.com>
 <1358953079-1277-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130123150615.GT1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 03:57:59PM +0100, Gregory CLEMENT wrote:
> When the patch "arm: mvebu: Use dw-apb-uart instead of ns16650 as UART
> driver" was applied to a git tree and became the commit b24212fbfba25
> it wrongly removed the i2c support. This patch reintroduce it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
