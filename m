From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 5 Feb 2013 22:40:39 +0800
Subject: [PATCH] pinctrl: sirf: replace of_gpio_simple_xlate by sirf
 specific of_xlate
In-Reply-To: <CACRpkdYvhBedZ+g4OtvfH11Pvq1kXOZQ7TtnNNyONYWC-ODEAA@mail.gmail.com>
References: <1359971614-18681-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdYvhBedZ+g4OtvfH11Pvq1kXOZQ7TtnNNyONYWC-ODEAA@mail.gmail.com>
Message-ID: <CAGsJ_4xCwD_oK57XFTrF_1T-tynh0e3-+h3p8ifmD9spwJ8-nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/5 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Feb 4, 2013 at 10:53 AM, Barry Song <Barry.Song@csr.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> the default of_gpio_simple_xlate() will make us fail while getting gpios
>> bigger than 32 by of_get_named_gpio() or related APIs.
>> this patch adds a specific of_xlate callback for sirf gpio_chip and fix
>> the problem.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Patch applied, hope this will be the last thing on fixes
> for this cycle. I really need to get the last fixes to Torvalds now.
>
at least it is my last :-)

> Yours,
> Linus Walleij
>
-barry
