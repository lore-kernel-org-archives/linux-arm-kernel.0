From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Oct 2017 08:30:20 +0200
Subject: [PATCH v2] arm64: qcom: sbc: Name GPIO lines
In-Reply-To: <20171011055405.GI1165@minitux>
References: <20171009092844.11451-1-linus.walleij@linaro.org>
 <20171011055405.GI1165@minitux>
Message-ID: <CACRpkdaBuWnimtaQBsT=OGt+2r0UiQzyNymDV_9PLBDDe0ASJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 7:54 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 09 Oct 02:28 PDT 2017, Linus Walleij wrote:

>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> [..]
>> +                             "NC", /* GPIO 70 */
>> +                             "NC",
>> +                             "NC",
>> +                             "NC",
>> +                             "NC", /* GPIO 74 */
>
> Convenient to know where index 74 is ;P

There is actually a reason for that. 74 begins the next sheet on the schematic
so engineers working with checking the line table against the schematic are
helped by this.

> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks man!

Yours,
Linus Walleij
