From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 24 May 2016 11:29:00 -0700
Subject: [PATCH 0/7] pinctrl: meson: Add a bunch more pins
In-Reply-To: <CACRpkdY9oGZLt431NwTaFmZk98O8n3ZnMA1odhYZtcH7P1p=Jg@mail.gmail.com>
 (Linus Walleij's message of "Tue, 24 May 2016 11:23:37 +0200")
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
 <CACRpkdY9oGZLt431NwTaFmZk98O8n3ZnMA1odhYZtcH7P1p=Jg@mail.gmail.com>
Message-ID: <m260u3ia37.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Fri, May 6, 2016 at 4:21 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> Add support for several more devices, both in the EE domain and in the
>> AO domain.  Also, add the pins to the corresponding DTS files.
>>
>> Tested on odroid-c2 and Amlogic P200 boards, and verified with working
>> ethernet.
>>
>> Depends on the initial GXBB pinctrl support from Carlo[1].  Also
>> available in my git tree[2] with all the dependencies included.
>
> These don't apply anomore sadly, Kevin can you rebase on
> Torvalds' HEAD and resend, and include Carlo's ACK on them
> so I can merge them in the next kernel cycle?

Looking closer, these have dependencies on the DT changes that you've
suggested we take through arm-soc, so it would be cleaner if I take
these with your ack through the amlogic tree.

Since it's a brand new driver, I don't expect there to be conflicts.

Does that work for you?

Kevin
