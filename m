From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jan 2015 11:05:27 +0100
Subject: [PATCH 1/2] pinctrl: exynos: Add AUDIO pin controller for exynos7
In-Reply-To: <CA+Ln22GhnW5jcXdQfYaJ_aM4Wq9OHXvShHHaxLKjJi+dp6Afcg@mail.gmail.com>
References: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
 <1418994659-5222-2-git-send-email-padma.v@samsung.com>
 <CACRpkdZopjCN_GMEPQFd_NWa0Ddocqt3aViLrZ7Yh3ui_YcBAg@mail.gmail.com>
 <CA+Ln22GhnW5jcXdQfYaJ_aM4Wq9OHXvShHHaxLKjJi+dp6Afcg@mail.gmail.com>
Message-ID: <CACRpkdaE8fY1OWy6VPucWVDRmTCRuE4fENZwsu6M3oSYv0DTvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 3:27 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 2015-01-14 20:40 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Fri, Dec 19, 2014 at 2:10 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
>>
>>> Audio IPs on Exynos7 require gpios available in AUDIO
>>> pin controller block. So adding the AUDIO pinctrl support.
>>>
>>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> (...)
>>> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>> @@ -181,6 +181,7 @@ Aliases for controllers compatible with "samsung,exynos7-pinctrl":
>>>  - pinctrl6: pin controller of FSYS0 block,
>>>  - pinctrl7: pin controller of FSYS1 block,
>>>  - pinctrl8: pin controller of BUS1 block,
>>> +- pinctrl9: pin controller of AUDIO block,
>>
>> This doesn't apply at all, the list has never been in the document merged
>> upstream.
>
> I believe this patch depends on patch [1], which was mentioned in
> cover letter and which you seem to have applied two days ago. If it
> still doesn't apply, please let me know if I should collect the
> patches myself and prepare a pull request for you.
>
> [1] https://patchwork.kernel.org/patch/5467321/

It applied when I tried it now, sorry I must have screwed up or something :(

Patch applied!

Yours,
Linus Walleij
