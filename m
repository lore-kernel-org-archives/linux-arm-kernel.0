From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2016 14:19:27 +0200
Subject: [PATCH] pinctrl: meson: Fix eth_tx_en bit index
In-Reply-To: <CAOQ7t2bK-9Ogw4aRhLYPFFJrwEevq_SuOJ6LjxwhJrJgcW+e-A@mail.gmail.com>
References: <1462730389-10961-1-git-send-email-serveralex@gmail.com>
 <1462730389-10961-2-git-send-email-serveralex@gmail.com>
 <CACRpkdZz631dio28wqa71uZe3=NSZO55RCxZaQSixfH-o1f4Cw@mail.gmail.com>
 <CAOQ7t2bK-9Ogw4aRhLYPFFJrwEevq_SuOJ6LjxwhJrJgcW+e-A@mail.gmail.com>
Message-ID: <CACRpkdY7SfFN3LqAowNSyit0sV6W0J4fENEtBhLfmfnPg+xSPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 11:13 AM, Carlo Caione <carlo@caione.org> wrote:
> On Wed, May 11, 2016 at 10:58 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Sun, May 8, 2016 at 7:59 PM, Alexander M?ller <serveralex@gmail.com> wrote:
>>
>>> Fix pinctrl eth_tx_en bit index according to Hardkernel ODROID-C1 datasheet.
>>>
>>> Signed-off-by: Alexander M?ller <serveralex@gmail.com>
>>
>> Carlo can you review this change?
>
> Acked-by: Carlo Caione <carlo@endlessm.com>

Thanks, patch applied with your ACK.

> just to let you know this patch has been posted also as part of a
> bigger patchset here
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/498960

Yeah I saw. But it seemed like an orthogonal fix so I better just
merge it now into the pin control tree.

Yours,
Linus Walleij
