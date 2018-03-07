From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 14:29:06 -0600
Subject: [PATCH v3 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
In-Reply-To: <1520002585-13113-2-git-send-email-amelie.delaunay@st.com>
References: <1520002585-13113-1-git-send-email-amelie.delaunay@st.com>
 <1520002585-13113-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <20180307202906.nn2y47f3yzply35s@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 03:56:24PM +0100, Amelie Delaunay wrote:
> This patch adds the device tree bindings description for STM32 USBPHYC
> (USB PHY Controller).
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
