From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Nov 2014 15:42:21 +0100
Subject: [PATCH] ARM: tegra: add serial aliases to Tegra124 DT
In-Reply-To: <1415053204-30114-1-git-send-email-dev@lynxeye.de>
References: <1415053204-30114-1-git-send-email-dev@lynxeye.de>
Message-ID: <20141106144219.GD12260@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 11:20:04PM +0100, Lucas Stach wrote:
> Provides consistent numbering of consoles across boards.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
> These aliases are already present in the base DTs for all
> other Tegra SoCs.
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied to the for-3.19/dt branch, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/f44fb056/attachment.sig>
