From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Oct 2012 01:11:06 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <50686955.8040503@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CAOY=C6GG6jqqEAAGJjmDG-BFT2eq=9+ck+F_EOcthRgDCDv8=Q@mail.gmail.com>
 <50682402.8020402@antcom.de>
 <CAOY=C6FaLckRHSfAHvw2=J9xZEVFDZPL+1oKnKeGnpOGPFVB1w@mail.gmail.com>
 <506860C6.5020408@antcom.de>
 <CAOY=C6F1rHoGM0T9FqLYuVwzaidDZBzEf_uWn9mP8fmT1oURTQ@mail.gmail.com>
 <50686955.8040503@antcom.de>
Message-ID: <CACRpkdbVLq3WsKZJ=K+CtuSNfZeDkCYhKwDmEwL4s2TC06WN-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 5:46 PM, Roland Stigge <stigge@antcom.de> wrote:
> On 30/09/12 17:19, Stijn Devriendt wrote:
>>
>> Rules are rules, but why make the interface overly complex when
>> the multi-value file is saner, cleaner and simpler?
>
> Simply because they won't (and probably shouldn't) accept it mainline.

We, including you and Stijn *are* the mainline ... ;-)

The only reason I really dislike it is that the GPIO sysfs interface is
scary as it is, so I don't want to add to it if we can instead push to
reform it into something more sane.

Linus Walleij
