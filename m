From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 May 2013 20:29:56 -0400
Subject: [PATCH V2 07/10] ARM: mvebu: Use standard MMC binding for all
 users of mvsdio
In-Reply-To: <1368479941-10084-8-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-8-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130515002956.GH31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 11:18:58PM +0200, Simon Baatz wrote:
> In order to prepare the switch to the standard MMC device tree parser
> for mvsdio, adapt all current uses of mvsdio in the dts files to the
> standard format.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts                |    1 +
>  arch/arm/boot/dts/armada-370-mirabox.dts           |    1 +
>  arch/arm/boot/dts/armada-370-rd.dts                |    1 +
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    4 ++++
>  arch/arm/boot/dts/armada-xp-db.dts                 |    1 +
>  arch/arm/boot/dts/kirkwood-dreamplug.dts           |    1 +
>  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    2 ++
>  arch/arm/boot/dts/kirkwood-mplcec4.dts             |    2 +-
>  arch/arm/boot/dts/kirkwood-topkick.dts             |    1 +
>  arch/arm/boot/dts/kirkwood.dtsi                    |    4 ++++
>  10 files changed, 17 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
