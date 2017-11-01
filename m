From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 16:12:58 -0500
Subject: [PATCH v2 01/10] dt-bindings: fix the binding of Allwinner DE2
 CCU of A83T and H3
In-Reply-To: <20171027150658.18509-2-icenowy@aosc.io>
References: <20171027150658.18509-1-icenowy@aosc.io>
 <20171027150658.18509-2-icenowy@aosc.io>
Message-ID: <20171101211258.m7lk4s2glhxhs7el@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 11:06:49PM +0800, Icenowy Zheng wrote:
> The DE2 CCU is different on A83T and H3 -- the parent of the clocks on
> A83T is PLL_DE but on H3 it's the DE module clock. This is not noticed
> when I develop the DE2 CCU driver.
> 
> Fix the binding by using different compatibles for A83T and H3, adding
> notes for the PLL_DE usage on A83T, and change the binding example's
> compatible from A83T to H3 (as it specifies the DE module clock).
> 
> Fixes: ed74f8a8a679 ("dt-bindings: add binding for the Allwinner DE2 CCU")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
