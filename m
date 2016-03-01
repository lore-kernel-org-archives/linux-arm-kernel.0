From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Mar 2016 15:28:12 +0100
Subject: [PATCH 1/2] arm64: tegra: Add DT entry for keys used in Jetson-TX1
In-Reply-To: <1456751211-14341-1-git-send-email-ldewangan@nvidia.com>
References: <1456751211-14341-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160301142812.GB26201@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 06:36:50PM +0530, Laxman Dewangan wrote:
> Add DT entry for keys used in Jetson-TX p2371-2180. This has
> three keys, POWER, VOLUME-UP and VOLUME-DOWN.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

I've applied this with a slightly modified commit message and moved the
gpio-keys node into the tegra210-p2597.dtsi file, because the GPIO keys
are part of the P2597 I/O board.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160301/43c15f99/attachment.sig>
