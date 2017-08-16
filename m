From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:19:57 +0200
Subject: [GIT PULL] Gemini DTS updates for v4.14 take one
In-Reply-To: <CACRpkdZYn1OXayC8ZdPeGJZ_ShQ5drRqVv5WBj3mdevqsHbCcw@mail.gmail.com>
References: <CACRpkdZYn1OXayC8ZdPeGJZ_ShQ5drRqVv5WBj3mdevqsHbCcw@mail.gmail.com>
Message-ID: <CAK8P3a0bWMx5NomSo54F5gRjXxVRHAMDAjj1e9ikmWgWqjzj8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 8, 2017 at 2:25 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi ARM SoC guys,
>
> this is the first set of DTS patches for Gemini for v4.14.
>
> - Moves to using macros (patch submitted to be applied on
>   top of v4.13-rc1 but it was missed, whatever)
>
> - New DTS for the D-Link DIR-685

Nice one! I had to look up what this actually is, apparently you can still
buy them new after all those years.

> - Modify all device trees to include proper pin control.
>
> This is infrastructure for any future extensions of the platform
> so it is all nice to have in place.
>
> Please pull it in on some appropriate branch!

Pulled into next/dt, thanks!

       Arnd
