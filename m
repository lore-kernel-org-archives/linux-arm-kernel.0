From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 11:46:00 -0500
Subject: [PATCH v2 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
In-Reply-To: <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
 <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170403164600.siab6ghtoeuxokg5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 02:32:37PM +0200, Fabrice Gasnier wrote:
> Add documentation for 'assigned-resolution-bits' dt optional property.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
>   is more common.
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
