From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 10:06:03 -0600
Subject: [PATCH v1 1/2] dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus
 support for I2C STM32F7
In-Reply-To: <1542370822-14721-2-git-send-email-pierre-yves.mordret@st.com>
References: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
 <1542370822-14721-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20181117160603.GA3681@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 13:20:21 +0100, Pierre-Yves MORDRET wrote:
> Append optional bindings to update SYSCFG Fast Mode Plus bits if
> Fast Mode Plus speed is selected.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
