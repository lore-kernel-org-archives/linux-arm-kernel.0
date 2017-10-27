From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Oct 2017 17:11:14 +0200
Subject: [PATCH v9 06/10] arm64: dts: allwinner: Restore EMAC changes
In-Reply-To: <20171024175714.15840-7-clabbe.montjoie@gmail.com>
References: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
 <20171024175714.15840-7-clabbe.montjoie@gmail.com>
Message-ID: <20171027151114.ax2yhf75lbho2js5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 07:57:10PM +0200, Corentin Labbe wrote:
> The original dwmac-sun8i DT bindings have some issue on how to handle
> integrated PHY and was reverted in last RC of 4.13.
> But now we have a solution so we need to get back that was reverted.
> 
> This patch restore arm64 DT about dwmac-sun8i
> This reverts commit 87e1f5e8bb4b ("arm64: dts: allwinner: Revert EMAC changes")
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts   | 16 ++++++++++++++++
>  .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts    | 15 +++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts  | 17 +++++++++++++++++
>  .../dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 16 ++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi        | 20 ++++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts     | 17 +++++++++++++++++
>  .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts    | 17 +++++++++++++++++
>  .../boot/dts/allwinner/sun50i-h5-orangepi-prime.dts  | 17 +++++++++++++++++
>  8 files changed, 135 insertions(+)

Can you split the changes between the A64 and the H5? It's going to be
difficult to merge otherwise.

(You also forgot to add Florian's Acked-by on your whole serie).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171027/15e5886e/attachment.sig>
