From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 9 Jan 2014 13:17:34 +0800
Subject: [PATCH 2/5] ARM: dts: SiRF: add lost usp1_uart_nostreamctrl pin
 group for atlas6
In-Reply-To: <CACRpkdbiPzB-MJr7Dm24b3cNd9urcT3SSV9qAz2iRPfCjygAHg@mail.gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
 <1388717966-11703-3-git-send-email-21cnbao@gmail.com>
 <CACRpkdbiPzB-MJr7Dm24b3cNd9urcT3SSV9qAz2iRPfCjygAHg@mail.gmail.com>
Message-ID: <CAGsJ_4zkw+VWewdjneuDK=C91vgJpZ12RbvrnY2Ss3Qj-AGa0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/8 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Jan 3, 2014 at 3:59 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>> this patch adds lost usp1_uart_nostreamctrl pin group for atlas6, which
>> matches with the change in drivers/pinctrl/sirf/pinctrl-atlas6.c.
>>
>> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Please funnel this patch through ARM SoC or similar sirf tree.

ok. i'll send a pull request including these two pinmux dts changes
and several other dts changes for 3.14.

>
> Yours,
> Linus Walleij

-barry
