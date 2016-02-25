From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 16:29:31 +0100
Subject: [PATCH 0/4] RealView boardfile endgame
In-Reply-To: <5411123.nOOnE7uo7z@wuerfel>
References: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
 <5411123.nOOnE7uo7z@wuerfel>
Message-ID: <CACRpkdZ_oyJNTzC6Ji+19aRy3Ex47u2Khqd7_RwuGdK+TLTy_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 3:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 25 February 2016 14:15:07 Linus Walleij wrote:
>> This patch set deletes the RealView board files and moves it
>> over to a pure Device Tree boot, deleting ~3500 LoC.
(...)
> This leaves the question whether we should do all the preparation
> in 4.6 and then only take these for 4.7, or do them all at
> once. I can see good reasons either way, but none of them
> particularly strong. What did you have in mind here?

If the dependencies in CLCD and MTD make it in we'll just
merge the whole thing IMO.

If these drag out, we merge the device trees and wait with
removing the board files until v4.7.

I will still have some remaining cleanup for Integrator, Versatile
and also Versatile Express however, but that is for later.

Yours,
Linus Walleij
