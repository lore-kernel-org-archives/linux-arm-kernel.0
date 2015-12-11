From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 19:34:10 +0100
Subject: [PATCH 1/2] ARM: mvebu: add kirkwood compatibles for cloudengine
 boards
In-Reply-To: <87a8pj8ww7.fsf@free-electrons.com>
References: <1448578854-6256-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdaJW6KLdnF4D2kyXuFeEyeNrM_epRodVmT2fQTUcBKbbQ@mail.gmail.com>
 <87a8pj8ww7.fsf@free-electrons.com>
Message-ID: <CACRpkdYaj3fkmSXoURaJXOP_5srUOtObZzxHoZzkPrqKRP+trg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2015 at 4:27 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Linus,
>
>  On mer., d?c. 09 2015, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> On Fri, Nov 27, 2015 at 12:00 AM, Linus Walleij
>> <linus.walleij@linaro.org> wrote:
>>
>>> This adds the compatible strings for Cloudengine PogoPlug E02 and
>>> series 4. The former already has a devicetree in the kernel.
>>>
>>> Cc: devicetree at vger.kernel.org
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Kirkwood maintainers: are you queueing this patch with Rob's
>> ACK?
>
> Actually I was waiting for a new version of the series with Adrew's
> comment addressed in the 2nd patch before applying the whole series.

OK I sent a new one of that earlier today, but I did not resend this one.
I think it stand on its own though? The compatible string for the machine
was never target of review comments.

Yours,
Linus Walleij
