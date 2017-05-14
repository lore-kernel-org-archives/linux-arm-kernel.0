From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 14 May 2017 09:20:57 +0200
Subject: [PATCH 1/2 v6] ARM: dts: add XOADC and IIO HWMON to
 MSM8660/APQ8060
In-Reply-To: <20170514033108.GB69278@Bjorns-MacBook-Pro-2.local>
References: <20170513141543.24759-1-linus.walleij@linaro.org>
 <20170514033108.GB69278@Bjorns-MacBook-Pro-2.local>
Message-ID: <CACRpkdYSGc6Y_VRe-gQ=WVGNONinpT6UGRqtMUuhfsc-Oz150A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 14, 2017 at 5:31 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Sat 13 May 07:15 PDT 2017, Linus Walleij wrote:
>
>> +                             xoadc: xoadc at 197 {
>> +                                     compatible = "qcom,pm8058-adc";
>> +                                     reg = <0x197>;
>> +                                     interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
>> +                                     #address-cells = <2>;
>> +                                     #size-cells = <0>;
>> +                                     #io-channel-cells = <2>;
>> +
>> +                                     vcoin: adc-channel at 00 {
>
> Is it possible to reference these nodes directly? Regardless they make
> the dts human readable, so I'm fine either way.

The alias is there to make it human readable, indeed.

> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks!

Linus
