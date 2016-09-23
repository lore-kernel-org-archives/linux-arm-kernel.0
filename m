From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 11:23:32 +0200
Subject: [PATCH 3/3] arm64: Add the Raspberry Pi firmware's interface to
 the FXL6408.
In-Reply-To: <1474577091.12009.10.camel@redhat.com>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-3-eric@anholt.net>
 <1474577091.12009.10.camel@redhat.com>
Message-ID: <CACRpkdZa_2XDVXS088GAacinHMiN9xqn+uGn1gqnarhqL7ec9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 10:44 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mo, 2016-09-19 at 17:13 +0100, Eric Anholt wrote:
>> This gets us hotplug detection of HDMI, so that graphics now works at
>> boot.  Tested with watching the output of xrandr while plugging and
>> unplugging the HDMI cable.
>
> Very nice.  Whole patch series:
>
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>
> /me hopes this lands in the 4.9 merge window.

Sorry no way. I have comments on the driver and
bindings.

Yours,
Linus Walleij
