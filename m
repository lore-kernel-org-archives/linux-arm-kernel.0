From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 12 Apr 2017 15:24:12 +0200
Subject: [PATCH v2 2/7] Documentation: dt: Remove bindings for STM32
 pinctrl
In-Reply-To: <20170410202054.urednfofxyb5iyou@rob-hp-laptop>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-3-git-send-email-alexandre.torgue@st.com>
 <20170410202054.urednfofxyb5iyou@rob-hp-laptop>
Message-ID: <dfcff424-6a41-a22e-817e-0ef68c26d9e4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 04/10/2017 10:20 PM, Rob Herring wrote:
> On Fri, Apr 07, 2017 at 02:42:59PM +0200, Alexandre TORGUE wrote:
>> Remove "ngpios" bindings definition as it is no more used in stm32 pinctrl
>> driver.
>
> I read the subject as "rm
> Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt". You can
> be more specific:
>
> dt-bindings: pinctrl: remove ngpios from stm32-pinctrl binding
>
> With that,
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Thanks for review. I think that documentations patches (patch 2 & 3) 
will be merged by Linus W.

Linus, do you want a V3 to fix commit header ?

Regards
Alex
