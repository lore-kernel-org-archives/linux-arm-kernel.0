From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 11:58:12 +0100
Subject: [PATCH v2 1/6] ARM: tegra: nyan: Use proper IRQ type definitions
In-Reply-To: <20170122154753.31942-1-contact@paulk.fr>
References: <20170122154753.31942-1-contact@paulk.fr>
Message-ID: <20170125105812.GB9344@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 04:47:48PM +0100, Paul Kocialkowski wrote:
> This switches a few interrupt definitions that were using
> GPIO_ACTIVE_HIGH as IRQ type, which is invalid.
> 
> This is mostly a cosmetic change, that doesn't affect any driver.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/2dbb3094/attachment.sig>
