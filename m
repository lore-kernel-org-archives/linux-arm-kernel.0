From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 20 Oct 2016 12:59:29 +0900
Subject: [PATCH v2 2/2] arm64: dts: uniphier: add CPU clocks and OPP
 tables for LD20 SoC
In-Reply-To: <20161020035542.GG11766@vireshk-i7>
References: <1476926126-6079-1-git-send-email-yamada.masahiro@socionext.com>
 <1476926126-6079-2-git-send-email-yamada.masahiro@socionext.com>
 <20161020035542.GG11766@vireshk-i7>
Message-ID: <CAK7LNAQj-mHoGvQ4KxoHSJa=JUAh5Bt0H8GF9SnLwZfw70_U_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-20 12:55 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 20-10-16, 10:15, Masahiro Yamada wrote:
>> +             opp at 666666666 {
>> +                     opp-hz = /bits/ 64 <666667000>;
>> +                     clock-latency-ns = <300>;
>> +             };
>> +             opp at 733333333 {
>> +                     opp-hz = /bits/ 64 <733334000>;
>> +                     clock-latency-ns = <300>;
>> +             };
>
> Forgot changing these ? Please make sure to update all of them.
>

Oops, I missed that.

Will fix soon.

Thanks!



-- 
Best Regards
Masahiro Yamada
