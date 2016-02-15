From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Feb 2016 10:17:23 +0100
Subject: [linux-sunxi] Re: [PATCH v2 3/5] pinctrl: sunxi: Add H3 R_PIO
 controller support
In-Reply-To: <20160215080816.GA6426@box2.japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-4-git-send-email-k@japko.eu>
 <CACRpkdZkSzcb0fmghkvsfRHpsU-SsSGPP6YvstAW7387HS0xJw@mail.gmail.com>
 <20160215080816.GA6426@box2.japko.eu>
Message-ID: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 9:08 AM, Krzysztof Adamski <k@japko.eu> wrote:
> On Thu, Feb 11, 2016 at 02:21:15PM +0100, Linus Walleij wrote:
>>
>> On Tue, Feb 2, 2016 at 10:21 PM, Krzysztof Adamski <k@japko.eu> wrote:
>>
>>> H3 has additional PIO controller similar to what we can find on A23.
>>> It's a 12 pin port, described in H3 Datasheet rev 1.1, pages 345-350.
>>>
>>> Signed-off-by: Krzysztof Adamski <k@japko.eu>
>>
>>
>> Patch applied with Maxime's ACK.
>
>
> Hi Linus,
>
> You took v2 which does not add documentation for
> allwinner,sun8i-h3-r-pinctrl compatible that is added in this patch.  This
> was fixed in v3. Should I prepare a patch for you that only adds this to the
> documentation or you can handle this by taking v3/v4 instead of this patch?

Ooops please send a fixup patch, I don't like to rebase the
tree if possible. Sorry for the mess and thanks for your help.

Yours,
Linus Walleij
