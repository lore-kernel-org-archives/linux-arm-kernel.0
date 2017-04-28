From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 12:52:57 -0500
Subject: [PATCH v5 01/11] dt-bindings: add binding for the Allwinner DE2
 CCU
In-Reply-To: <20170423103754.50012-2-icenowy@aosc.io>
References: <20170423103754.50012-1-icenowy@aosc.io>
 <20170423103754.50012-2-icenowy@aosc.io>
Message-ID: <20170428175257.iob2i33fjfyrg7cv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 23, 2017 at 06:37:44PM +0800, Icenowy Zheng wrote:
> Allwinner "Display Engine 2.0" contains some clock controls in it.
> 
> In order to add them as clock drivers, we need a device tree binding.
> Add the binding here.
> 
> Also add the device tree binding headers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v5:
> - Moved dt-binding headers here.
> - Changed dt-binding headers' license header to SPDX license.
> Changes in v4:
> - Dropped the leading 0 in clock at 1000000 .
> Changes in v3:
> - Fill the address space length of DE2 CCU to 0x100000, just reach the start of mixer0.
> 
>  .../devicetree/bindings/clock/sun8i-de2.txt        | 31 ++++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-de2.h              | 18 +++++++++++++
>  include/dt-bindings/reset/sun8i-de2.h              | 14 ++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt
>  create mode 100644 include/dt-bindings/clock/sun8i-de2.h
>  create mode 100644 include/dt-bindings/reset/sun8i-de2.h

Acked-by: Rob Herring <robh@kernel.org>
