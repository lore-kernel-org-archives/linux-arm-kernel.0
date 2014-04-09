From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Apr 2014 10:40:48 +0200
Subject: [RFC 0/3] future of gemini platform
In-Reply-To: <1357310500-19848-5-git-send-email-arnd@arndb.de>
References: <1357310500-19848-1-git-send-email-arnd@arndb.de>
 <1357310500-19848-5-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYuxJ2CWQGDCWx+4Yp2r3=OVunyx2kfTyBKay43jaHvnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 4, 2013 at 3:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The gemini platform is quite broken at the moment due to bitrot,
> here are the two suggested solutions. We should either apply the
> first patch or the other two, depending on whether anyone still
> uses this.
>
> Ulli was last actively working on this about two years ago,
> so I assume that he has moved on, but if he or anyone else
> is still interested in keeping Gemini alive, any patches
> and testing are very welcome. Without a maintainer however,
> I see no point in keeping it.
>
> The fa526 CPU support is currently only used on Gemini,
> but Florian had some patches last year for it, so he might
> still need it. If there are still plans to get MCS814x
> or another fa526 based platform merged into mainline,
> we can keep this around, but unless I see a timeline
> for this, I would prefer to remove it for now. It should
> be trivial to revert that patch and bring it back if
> it's needed for a new platform.
>
> Arnd Bergmann (3):
>   ARM: gemini: get platform to build again
>   ARM: gemini: remove platform support
>   ARM: remove fa526 CPU support

Arnd: I suggest you rebase and apply this series, sans the FA526
removal as I hear it may now be used on the Moxart.

I patched the generic time code for gemini in october last year
and noone has yet bothered to even test it!

Yours,
Linus Walleij
