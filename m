From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Oct 2017 09:38:09 -0500
Subject: [PATCH v1 1/2] dt-bindings: display: stm32: add a 2nd endpoint
In-Reply-To: <1509018489-19641-2-git-send-email-philippe.cornu@st.com>
References: <1509018489-19641-1-git-send-email-philippe.cornu@st.com>
 <1509018489-19641-2-git-send-email-philippe.cornu@st.com>
Message-ID: <20171027143809.ughycmycxmsrwwyp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 01:48:08PM +0200, Philippe Cornu wrote:
> ltdc can have up to 2 endpoints:
>  - dpi external gpios: for rgb panels or external bridge ICs.
>  - dpi internal ios: connected internally to dsi.
> 
> Note: Refer to the reference manual to know if the dsi is
> present on your device.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
