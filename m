From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 Feb 2015 15:22:01 +0000
Subject: [PATCH 4/6] ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
In-Reply-To: <20150225151229.GE5132@x1>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
 <1424871377-1795-5-git-send-email-peter.griffin@linaro.org>
 <20150225151229.GE5132@x1>
Message-ID: <20150225152201.GA14329@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 25 Feb 2015, Lee Jones wrote:

> > +			resets		= <&powerdown STIH407_USB3_POWERDOWN>,
> > +					  <&softreset STIH407_MIPHY2_SOFTRESET>;
> > +			reset-names	= "powerdown",
> > +					  "softreset";
> 
> Nit: What's the purpose of having these on separate lines?

The only reason was to stay aligned with the example in
Documentation/devicetree/bindings/usb/dwc3-st.txt.

regards,

Peter.
