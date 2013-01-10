From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 21:02:25 -0500
Subject: [PATCH V2 1/4] rtc: Add support of rtc-mv for MVEBU SoCs
In-Reply-To: <1355303186-9267-2-git-send-email-gregory.clement@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
 <1355303186-9267-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130110020225.GD5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 10:06:23AM +0100, Gregory CLEMENT wrote:
> The Armada 370 and Armada XP Socs have the same controller that the
> one used in the orion platforms. This patch enables the selection of
> rtc-mv with mvebu platforms.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/rtc/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/drivers

thx,

Jason.
