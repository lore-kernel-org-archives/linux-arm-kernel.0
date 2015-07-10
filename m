From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 10 Jul 2015 17:58:02 +0200
Subject: [PATCH v3 5/5] arm64: dts: mt8173: Add subsystem clock controller
 device nodes
In-Reply-To: <CAGS+omC7274iPDdfXpKuM0HvCcEscUE5e5jrDH4DhW4j_Ykt2A@mail.gmail.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436522405-13923-6-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omC7274iPDdfXpKuM0HvCcEscUE5e5jrDH4DhW4j_Ykt2A@mail.gmail.com>
Message-ID: <CABuKBe+oLmRRHZKnBsfU8icf2r2f3+XrPNMVw_QaGPE9vVxGFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-10 17:02 GMT+02:00 Daniel Kurtz <djkurtz@chromium.org>:
>
> On Jul 10, 2015 18:00, "James Liao" <jamesjj.liao@mediatek.com> wrote:
>>
>> This patch adds device nodes providing subsystem clocks on MT8173,
>> includes mmsys, imgsys, vdecsys, vencsys and vencltsys.
>>
>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 30
>> ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index a2f63e4..9d74ce5 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -227,6 +227,36 @@
>>                         clocks = <&uart_clk>;
>>                         status = "disabled";
>>                 };
>> +
>> +               mmsys: mmsys at 14000000 {
>
> I think we agreed previously that these should all be clock-controller at .
>

I did understand the same.
Please change that.

Thanks.
