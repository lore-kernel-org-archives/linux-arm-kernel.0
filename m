From: fkan@apm.com (Feng Kan)
Date: Fri, 14 Nov 2014 11:26:04 -0800
Subject: [PATCH V2 4/7] arm64: dts: Add Designware GPIO dts binding to APM
 X-Gene platform
In-Reply-To: <1829495.FoDfH1G36W@wuerfel>
References: <1415924401-3013-1-git-send-email-fkan@apm.com>
 <1415924401-3013-5-git-send-email-fkan@apm.com>
 <1829495.FoDfH1G36W@wuerfel>
Message-ID: <CAL85gmDYM2V=TCtA5iBazj+k6rfvpd6c2dnqaA2jfifyxeZR_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 7:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 13 November 2014 16:19:58 Feng Kan wrote:
>> +               dwgpio: dwgpio at 1c024000 {
>> +                       compatible = "snps,dw-apb-gpio";
>> +                       reg = <0x0 0x1c024000 0x0 0x1000>;
>> +                       reg-io-width = <4>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>>
>
> Same comment as patch 1: make the node name 'gpio', not 'dwgpio'.

I can make this change.
>
>         Arnd
