From: kvalo@codeaurora.org (Kalle Valo)
Date: Wed, 04 Oct 2017 12:02:17 +0300
Subject: [PATCH v3 1/2] dt-bindings: add device tree binding for Allwinner
 XR819 SDIO Wi-Fi
In-Reply-To: <20171003165944.13056-2-icenowy@aosc.io> (Icenowy Zheng's message
 of "Wed, 4 Oct 2017 00:59:43 +0800")
References: <20171003165944.13056-1-icenowy@aosc.io>
 <20171003165944.13056-2-icenowy@aosc.io>
Message-ID: <871smjxp46.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Icenowy Zheng <icenowy@aosc.io> writes:

> Allwinner XR819 is a SDIO Wi-Fi chip, which has the functionality to use
> an out-of-band interrupt pin instead of SDIO in-band interrupt.
>
> Add the device tree binding of this chip, in order to make it possible
> to add this interrupt pin to device trees.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> - Renames the node name.
> - Adds ACK from Rob.
> Changes in v2:
> - Removed status property in example.
> - Added required property reg.
>
>  .../bindings/net/wireless/allwinner,xr819.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/allwinner,xr819.txt

Like I asked already last time, AFAICS there is no upstream xr819
wireless driver in drivers/net/wireless directory. Do we still accept
bindings like this for out-of-tree drivers?

-- 
Kalle Valo
