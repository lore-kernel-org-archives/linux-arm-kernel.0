From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 13:42:57 +0100
Subject: [PATCH v4] drivers/pinctrl: grab default handles from device core
In-Reply-To: <20130121234158.GA9322@kroah.com>
References: <1358795855-21064-1-git-send-email-linus.walleij@stericsson.com>
 <20130121234158.GA9322@kroah.com>
Message-ID: <CACRpkdY2LF4Kg0LsZGThKpQfv=TPfK9NfX0O71OHeT+Jqh++hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 12:41 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Jan 21, 2013 at 08:17:35PM +0100, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This makes the device core auto-grab the pinctrl handle and set
>> the "default" (PINCTRL_STATE_DEFAULT) state for every device
>> that is present in the device model right before probe. This will
>> account for the lion's share of embedded silicon devcies.
(...)
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Feel free to take this through your tree.

Thanks Greg!

Stephen W, are you OK with me pushing this version of the patch
now?

I have your fix and hopefully the other required fixes in the patch
so as not to break Tegra, but prefer to have it solidly tested
if possible.

Yours,
Linus Walleij
