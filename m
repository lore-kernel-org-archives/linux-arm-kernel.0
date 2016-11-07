From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 14:28:54 +0100
Subject: [PATCH] ARM: tegra: nyan: Mark all USB ports as host
In-Reply-To: <20160918102852.6593-1-contact@paulk.fr>
References: <20160918102852.6593-1-contact@paulk.fr>
Message-ID: <20161107132854.GF12559@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 12:28:52PM +0200, Paul Kocialkowski wrote:
> Nyan boards only have host USB ports (2 external, 1 internal), there is
> no OTG-enabled connector.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Where is this information coming from? I don't have one of the Nyans
myself, but one of the Tegra132 devices I have, which I think was
derived from one of the Nyans uses one of the external host ports as
forced recovery port, for which it would need OTG.

I suspect that the way to get U-Boot onto the Nyans is via tegrarcm?
In that case I think one of the ports must be OTG.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/7889311c/attachment.sig>
