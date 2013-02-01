From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Feb 2013 10:53:36 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add of_xlate function
In-Reply-To: <51085315.2000302@free-electrons.com>
References: <1359313332-12305-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359313332-12305-2-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdZi0zCNf6LDd9UAcd57kFqqWyteVqxL8WfDrFfrt9_5sQ@mail.gmail.com>
 <51085315.2000302@free-electrons.com>
Message-ID: <CACRpkdYzX8PFVLei0+UJvEA6rGq_RBGsMKdRs0RnmAQL3h7S5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 11:54 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Le 29/01/2013 23:41, Linus Walleij a ?crit :
>> On Sun, Jan 27, 2013 at 8:02 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>
>>> Since the pin controller of sunxi chips is represented as a single bank
>>> in the driver.
>>> Since this is neither convenient nor represented that way in the
>>> datasheets, define a custom of_xlate function with the layout <bank pin
>>> flag>
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> This does not apply and I only have 1/3 it seems?
>>
>> Sorry, help me understand which order these patches go in...
>
> My bad, I forgot to mention the order of the patchsets, and to cc you
> for the all series... Sorry about that.
>
> This patch should come after the patch series that adds the support for
> the A10 SoCs in the pinctrl driver.

I now tried to apply this on top of the A10 series and it
*still* does not apply.

> Do you want me to resend this serie and cc you?

Please rebase these three on my allwinner branch:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
allwinner-sunxi

Seen here:
http://git.kernel.org/?p=linux/kernel/git/linusw/linux-pinctrl.git;a=shortlog;h=refs/heads/allwinner-sunxi

Yours,
Linus Walleij
