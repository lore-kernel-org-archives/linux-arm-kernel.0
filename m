From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 08:58:31 -0500
Subject: [PATCH v4 01/11] dt-bindings: add binding for the Allwinner DE2
 CCU
In-Reply-To: <20170416120849.54542-2-icenowy@aosc.io>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-2-icenowy@aosc.io>
Message-ID: <20170420135831.owkaymplu4tbzdzs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 16, 2017 at 08:08:39PM +0800, Icenowy Zheng wrote:
> Allwinner "Display Engine 2.0" contains some clock controls in it.
> 
> In order to add them as clock drivers, we need a device tree binding.
> Add the binding here.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Dropped the leading 0 in clock at 1000000 .
> Changes in v3:
> - Fill the address space length of DE2 CCU to 0x100000, just reach the start of mixer0.
> 
>  .../devicetree/bindings/clock/sun8i-de2.txt        | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt

Acked-by: Rob Herring <robh@kernel.org>
