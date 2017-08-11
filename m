From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 21:51:34 -0500
Subject: [PATCH] dt-bindings: clock: sunxi-ccu: Add compatibles for sun5i
 CCU driver
In-Reply-To: <20170808012540.16691-1-net147@gmail.com>
References: <20170808012540.16691-1-net147@gmail.com>
Message-ID: <20170811025134.ee4v2tbol2pjcd4i@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:25:40AM +1000, Jonathan Liu wrote:
> The bindings were not updated when the sun5i CCU driver was added in
> commit 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver").
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
