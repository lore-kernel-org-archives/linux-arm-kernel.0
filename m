From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 26 Dec 2017 13:00:22 -0600
Subject: [PATCH v3 01/11] dt-bindings: fix the binding of Allwinner DE2
 CCU of A83T and H3
In-Reply-To: <20171222122243.25735-2-icenowy@aosc.io>
References: <20171222122243.25735-1-icenowy@aosc.io>
 <20171222122243.25735-2-icenowy@aosc.io>
Message-ID: <CAL_JsqLh4dgWOcsZ0aXCKvEUsANE=enPB0f-LthYOjRGZCkUfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 6:22 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
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

Please add acks when posting new versions.

Rob
