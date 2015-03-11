From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Mar 2015 10:02:27 +0100
Subject: [PATCH] ARM: tegra: import latest Jetson TK1 pinmux
In-Reply-To: <1424199465-11041-1-git-send-email-swarren@wwwdotorg.org>
References: <1424199465-11041-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20150311090226.GE19577@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 11:57:45AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> syseng has revamped the Jetson TK1 pinmux spreadsheet, basing the content
> completely on correct configuration for the board/schematic, rather than
> the previous version which was based on the bare minimum changes relative
> to another reference board.
> 
> This content comes from Jetson_TK1_customer_pinmux.xlsm (v09) downloaded
> from https://developer.nvidia.com/hardware-design-and-development.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 557 ++++++++++++++----------------
>  1 file changed, 254 insertions(+), 303 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/119b172a/attachment.sig>
