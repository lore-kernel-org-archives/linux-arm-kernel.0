From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 12 Apr 2016 17:43:23 +0800
Subject: [PATCH v3 04/16] arm64: dts: Add Hi6220 gpio configuration nodes
In-Reply-To: <CACRpkdZNTJB_Jn01AwhwHf77yk-Cb_yzj4ty6N1b6wbHmfoevA@mail.gmail.com>
References: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
 <1459862860-9775-5-git-send-email-guodong.xu@linaro.org>
 <CACRpkdZNTJB_Jn01AwhwHf77yk-Cb_yzj4ty6N1b6wbHmfoevA@mail.gmail.com>
Message-ID: <CAFGCpxz+ZZE-NT11+2GEoKX4dhmju+4zxG04Nt-gPGqR8kwy7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2016 at 20:19, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 5, 2016 at 3:27 PM, Guodong Xu <guodong.xu@linaro.org> wrote:
>
>> From: Zhong Kaihua <zhongkaihua@huawei.com>
>>
>> Add Hi6220 gpio configuration nodes
>>
>> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
>> Signed-off-by: Kong Xinwei <kong.kongxinwei@hisilicon.com>
>>
>
> I asked you to remove this blank line.

will fix.

>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
>
> (...)
>> +++ b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
>> @@ -0,0 +1,607 @@
>> +/ {
>> +       gpio_rstout_n:gpio_rstout_n {
>> +               gpios;
>> +       };
>
> I also asked about either explaining or removing this.
>
> Did my mail arrive?

It arrived. My mistake, sorry, i missed. I will remove this file. And
send a new version.

-Guodong

>
> Yours,
> Linus Walleij
