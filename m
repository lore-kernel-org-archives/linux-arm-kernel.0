From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 10:56:24 +0100
Subject: [PATCH v4 1/6] gpio: davinci: Fixed a check for unbanked gpio
In-Reply-To: <CA+V-a8tE3bxsHMSh2i3Xeq=kJUjmxTjcU25Kuka5e_iXeB--pQ@mail.gmail.com>
References: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
 <1383406775-14902-2-git-send-email-prabhakar.csenng@gmail.com>
 <CACRpkdZ7pwGQnK0NN4tybLUNdMxu5WVaGX8Dqu+kMgVBuyF16w@mail.gmail.com>
 <CA+V-a8tE3bxsHMSh2i3Xeq=kJUjmxTjcU25Kuka5e_iXeB--pQ@mail.gmail.com>
Message-ID: <CACRpkdbLTopHMaog7FDW7O4-yLyv+mmnvgkNuXgeQR-pEtbz6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 10:33 AM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Nov 5, 2013 at 6:09 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Nov 2, 2013 at 4:39 PM, Lad, Prabhakar
>> <prabhakar.csengg@gmail.com> wrote:
>>
>>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>>
>>> This patch fixes the check for the offset in
>>> gpio_to_irq_unbanked() function.
>>>
>>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>
>> Is this a regression that should go in right now?
>>
> Yes it needs too.

But on top of *what* exactly?

This does not apply to my gpio tree devel branch and
not even on the mainline kernel.

Is this something that should go on top of the davinci
GPIO patch set that is still being elaborated on?

Yours,
Linus Walleij
