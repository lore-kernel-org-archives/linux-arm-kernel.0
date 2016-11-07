From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 14:29:45 +0100
Subject: [PATCH] ARM: tegra: nyan: Enable GPU node and related supply
In-Reply-To: <20160918141311.17140-1-contact@paulk.fr>
References: <20160918141311.17140-1-contact@paulk.fr>
Message-ID: <20161107132945.GG12559@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 04:13:11PM +0200, Paul Kocialkowski wrote:
> This enables the GPU node for tegra124 nyan boards, which is required to
> get graphics acceleration with nouveau on these devices.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/edbcbb97/attachment.sig>
