From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 16:11:32 -0500
Subject: [PATCH v2 08/10] dt-bindings: add binding for A64 DE2 CCU SRAM
In-Reply-To: <20171027150658.18509-9-icenowy@aosc.io>
References: <20171027150658.18509-1-icenowy@aosc.io>
 <20171027150658.18509-9-icenowy@aosc.io>
Message-ID: <20171101211132.jtbhywkudrev4ux3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 11:06:56PM +0800, Icenowy Zheng wrote:
> A64's Display Engine 2.0 needs a section of SRAM (SRAM C) to be claimed,
> otherwise the whole DE2 memory zone cannot be accessed (kept to all 0).
> 
> Add binding for this, in order to make the DE2 CCU able to claim the
> SRAM and enable access to the DE2 clock and reset registers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Adds description of the situation when the SRAM is not claimed.
> 
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
