From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 10:59:10 -0500
Subject: [PATCH v3 1/3] dt-bindings: Add support for samsung s6e3hf2 panel
In-Reply-To: <1492504836-19225-2-git-send-email-hoegeun.kwon@samsung.com>
References: <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170418084047epcas5p440464afa8770d07253f42f362764059b@epcas5p4.samsung.com>
 <1492504836-19225-2-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170420155910.jv33e5iyiqxam5fg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 05:40:34PM +0900, Hoegeun Kwon wrote:
> The samsung s6e3hf2 panel is a 5.65" 1600x2560 AMOLED panel connected
> using MIPI-DSI interfaces.
> 
> The s6e3hf2 is add to samsung,s6e3ha2.txt binding because it is a
> panel similar to the s6e3ha2. So add the compatible string and
> comments.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
