From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 10:53:34 +0200
Subject: [PATCH v4 1/7] pinctrl: bcm2835: add pull defines to dt bindings
In-Reply-To: <87zin49p9m.fsf@eliezer.anholt.net>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
 <1474274603-24215-2-git-send-email-kraxel@redhat.com>
 <87zin49p9m.fsf@eliezer.anholt.net>
Message-ID: <CACRpkdZ9NmFGtGcT_KfoLLUqoLic7i9_ao7cw8JgSnq2o0VvnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 12:07 PM, Eric Anholt <eric@anholt.net> wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>> Also delete (unused) private enum from driver.
>> The pull defines can be used instead if needed.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Acked-by: Eric Anholt <eric@anholt.net>
>
> gpio maintainers, could I pull this through my dt tree?  Or does this
> need to be split in two?

You can take it. The bcm2835 driver is not seeing any conflicting
changes in this merge window.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
