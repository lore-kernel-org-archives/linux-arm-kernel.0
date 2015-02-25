From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 25 Feb 2015 15:50:05 +0000
Subject: [PATCH 4/6] ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
In-Reply-To: <20150225152201.GA14329@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
 <1424871377-1795-5-git-send-email-peter.griffin@linaro.org>
 <20150225151229.GE5132@x1>
 <20150225152201.GA14329@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150225155005.GE6688@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015, Peter Griffin wrote:

> Hi Lee,
> 
> On Wed, 25 Feb 2015, Lee Jones wrote:
> 
> > > +			resets		= <&powerdown STIH407_USB3_POWERDOWN>,
> > > +					  <&softreset STIH407_MIPHY2_SOFTRESET>;
> > > +			reset-names	= "powerdown",
> > > +					  "softreset";
> > 
> > Nit: What's the purpose of having these on separate lines?
> 
> The only reason was to stay aligned with the example in
> Documentation/devicetree/bindings/usb/dwc3-st.txt.

But didn't you author that too? :)

I would change them both.  No need to force a line wrap if it's not required.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
