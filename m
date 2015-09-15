From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Sep 2015 10:14:26 +0200
Subject: [PATCH] arm: tegra: dtsi whitespace clean-up for tegra20,
 tegra30 and tegra124
In-Reply-To: <1440668688-17288-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440668688-17288-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20150915081425.GB25970@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 11:44:48AM +0200, Marcel Ziswiler wrote:
> There were a few cases of eight spaces being used instead of a tab
> character plus one case of using two spaces after an equal sign instead
> of just one which this patch fixes.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  arch/arm/boot/dts/tegra124.dtsi |  2 +-
>  arch/arm/boot/dts/tegra20.dtsi  |  4 ++--
>  arch/arm/boot/dts/tegra30.dtsi  | 10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)

Applied with tiny fixups of the commit message.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/ee62e9c9/attachment.sig>
