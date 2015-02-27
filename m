From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 27 Feb 2015 10:43:53 +0000
Subject: [PATCH 4/6] ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
In-Reply-To: <20150225155005.GE6688@x1>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
 <1424871377-1795-5-git-send-email-peter.griffin@linaro.org>
 <20150225151229.GE5132@x1>
 <20150225152201.GA14329@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150225155005.GE6688@x1>
Message-ID: <20150227104353.GB9094@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 25 Feb 2015, Lee Jones wrote:

> > > > +			reset-names	= "powerdown",
> > > > +					  "softreset";
> > > 
> > > Nit: What's the purpose of having these on separate lines?
> > 
> > The only reason was to stay aligned with the example in
> > Documentation/devicetree/bindings/usb/dwc3-st.txt.
> 
> But didn't you author that too? :)

Yep

> 
> I would change them both.  No need to force a line wrap if it's not required.

Ok, I'll remove it from both in v2, whilst adding the acks.

regards,

Peter.
