From: dianders@chromium.org (Doug Anderson)
Date: Wed, 22 Aug 2018 10:37:54 -0700
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
In-Reply-To: <153478902525.28926.6688429060107225232@swboyd.mtv.corp.google.com>
References: <20180810215150.82490-1-dianders@chromium.org>
 <20180810215150.82490-2-dianders@chromium.org>
 <153478902525.28926.6688429060107225232@swboyd.mtv.corp.google.com>
Message-ID: <CAD=FV=V=Me8g1MN1ZnV2JzHuLLppGr1JwnXZBBPDY1iHVivFFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 20, 2018 at 11:17 AM, Stephen Boyd <swboyd@chromium.org> wrote:
>> +               qfprom at 784000 {
>
> This doesn't match reg property.
>
>> +                       compatible = "qcom,qfprom";
>> +                       reg = <0x780000 0x8ff>;
>
> Because this should be 0x784000?

Thank you for catching.  This ought to be fixed in v3.

-Doug
