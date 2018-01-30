From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 30 Jan 2018 11:51:54 +0100
Subject: [PATCH] dt-bindings: display: stm32: correct clock-names in dsi
 panel example
In-Reply-To: <20180129231518.mocdpegeagbs4z5n@rob-hp-laptop>
References: <20180122153547.23470-1-philippe.cornu@st.com>
 <20180129231518.mocdpegeagbs4z5n@rob-hp-laptop>
Message-ID: <CA+M3ks78kufDB4QSd38Ah15zidbuHnY3kHMHXB_0iQFFg1VVkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-30 0:15 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Mon, Jan 22, 2018 at 04:35:47PM +0100, Philippe Cornu wrote:
>> In the dsi panel example, clock names in the "clock-names"
>> field have been swapped:
>> * "pclk" (peripheral clock) is <&rcc 1 CLK_F469_DSI> on stm32f4
>> * "ref" (dsi phy pll ref clock) is <&clk_hse> on stm32f4
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
Applied on drm-misc-next.

Regards,
Benjamin
