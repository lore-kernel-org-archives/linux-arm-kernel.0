From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 3 Mar 2015 11:16:33 +0100
Subject: [PATCH 4/6] ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
In-Reply-To: <20150227104353.GB9094@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
 <1424871377-1795-5-git-send-email-peter.griffin@linaro.org>
 <20150225151229.GE5132@x1>
 <20150225152201.GA14329@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150225155005.GE6688@x1>
 <20150227104353.GB9094@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <54F58A01.7090806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 02/27/2015 11:43 AM, Peter Griffin wrote:
> Hi Lee,
>
> On Wed, 25 Feb 2015, Lee Jones wrote:
>
>>>>> +			reset-names	= "powerdown",
>>>>> +					  "softreset";
>>>> Nit: What's the purpose of having these on separate lines?
>>> The only reason was to stay aligned with the example in
>>> Documentation/devicetree/bindings/usb/dwc3-st.txt.
>> But didn't you author that too? :)
> Yep
>
>> I would change them both.  No need to force a line wrap if it's not required.
> Ok, I'll remove it from both in v2, whilst adding the acks.
Thanks. Once fixed, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

BR,
Maxime
>
> regards,
>
> Peter.
