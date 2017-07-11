From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 21:57:54 -0500
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Add support for
 Orise Tech otm8009a dsi panel
In-Reply-To: <1499677333-10571-3-git-send-email-philippe.cornu@st.com>
References: <1499677333-10571-1-git-send-email-philippe.cornu@st.com>
 <1499677333-10571-3-git-send-email-philippe.cornu@st.com>
Message-ID: <20170711025754.qxb6jkdxhrj45eh3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 11:02:12AM +0200, Philippe CORNU wrote:
> The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
> a MIPI-DSI video interface. Its backlight is managed through the DSI link.
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>  .../bindings/display/panel/orisetech,otm8009a.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt

Acked-by: Rob Herring <robh@kernel.org>
