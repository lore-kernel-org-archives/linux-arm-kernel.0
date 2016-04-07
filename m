From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Apr 2016 12:57:25 -0500
Subject: [PATCH RFC 1/5] net: phy: sun8i-h3-ephy: Add bindings for
 Allwinner H3 Ethernet PHY
In-Reply-To: <1459786954-12649-2-git-send-email-wens@csie.org>
References: <1459786954-12649-1-git-send-email-wens@csie.org>
 <1459786954-12649-2-git-send-email-wens@csie.org>
Message-ID: <20160407175725.GG32257@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 12:22:30AM +0800, Chen-Yu Tsai wrote:
> The Allwinner H3 SoC incorporates an Ethernet PHY. This is enabled and
> configured through a memory mapped hardware register.
> 
> This same register also configures the MAC interface mode and TX clock
> source. Also covered by the register, but not supported in these bindings,
> are TX/RX clock delay chains and inverters, and an RMII module.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/net/allwinner,sun8i-h3-ephy.txt       | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-h3-ephy.txt

Acked-by: Rob Herring <robh@kernel.org>
