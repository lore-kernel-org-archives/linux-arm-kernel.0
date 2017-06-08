From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Jun 2017 12:01:43 -0500
Subject: [PATCH v3 4/6] dt-bindings: display: stm32: remove
 st-display-subsystem parent node requirement
In-Reply-To: <1496414235-20098-5-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
 <1496414235-20098-5-git-send-email-philippe.cornu@st.com>
Message-ID: <20170608170143.2wtctnpjw3uwgsgm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 04:37:13PM +0200, Philippe CORNU wrote:
> There is no need anymore to have a "st-display-subsystem" parent node
> in the device tree for the ltdc.
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
