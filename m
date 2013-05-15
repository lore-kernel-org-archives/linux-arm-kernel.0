From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 May 2013 20:31:32 -0400
Subject: [PATCH V2 09/10] ARM: Kirkwood: Add dts files for Sheevaplug
 and eSATA Sheevaplug
In-Reply-To: <1368479941-10084-10-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-10-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130515003132.GI31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 11:19:00PM +0200, Simon Baatz wrote:
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                        |    2 +
>  arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi |   97 +++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts   |   40 +++++++++
>  arch/arm/boot/dts/kirkwood-sheevaplug.dts         |   45 ++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug.dts

Applied to mvebu/dt

thx,

Jason.
