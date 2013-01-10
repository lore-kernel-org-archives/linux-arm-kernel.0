From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 21:03:50 -0500
Subject: [PATCH V2 4/4] arm: mvebu: Update defconfig with Marvell RTC
 support
In-Reply-To: <1355303186-9267-5-git-send-email-gregory.clement@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
 <1355303186-9267-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130110020350.GF5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 10:06:26AM +0100, Gregory CLEMENT wrote:
> The RTC class driver is already part of the mvebu_defconfig but the
> Marvell internal RTC not yet. Now that its support is added for mvebu
> let's update the config file.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/boards

thx,

Jason.
