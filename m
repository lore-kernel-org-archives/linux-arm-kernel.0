From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:13:40 +0200
Subject: [PATCH] gpio: mvebu: change compatible string for PWM support
In-Reply-To: <CACQ1gAht7kPysPofvyykYrfcRgJ_i_FFC8NqyN+J2L9WXwHfcg@mail.gmail.com>
References: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
 <CACRpkdY7yy=U1DgFHXGd06UXg0hh5eC7mBKHLr7hq01hR__q8g@mail.gmail.com>
 <CACQ1gAht7kPysPofvyykYrfcRgJ_i_FFC8NqyN+J2L9WXwHfcg@mail.gmail.com>
Message-ID: <CACRpkdZErh0PKy6+D7a23Js5d9n+eN_HVXhuatOFHGJRfObogA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 9:45 AM, Richard Genoud <richard.genoud@gmail.com> wrote:
> 2017-06-09 9:42 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Thu, Jun 1, 2017 at 10:08 PM, Ralph Sennhauser
>> <ralph.sennhauser@gmail.com> wrote:
>>
>>> As it turns out more than just Armada 370 and XP support using GPIO
>>> lines as PWM lines. For example the Armada 38x family has the same
>>> hardware support. As such "marvell,armada-370-xp-gpio" for the
>>> compatible string is a misnomer.
>>>
>>> Change the compatible string to "marvell,armada-370-gpio" before the
>>> driver makes it out of the -rc stage. This also follows the practice of
>>> using only the first device family supported as part of the name.
>>>
>>> Also update the documentation and comments in the code accordingly.
>>>
>>> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
>>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>>
>> Patch applied for next with the tags.
> You mean for fixes right ?
> The goal was to correct "marvell,armada-370-xp-gpio" before 4.12 is out.

OK I moved it to fixes.

Yours,
Linus Walleij
