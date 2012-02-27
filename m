From: stigge@antcom.de (Roland Stigge)
Date: Mon, 27 Feb 2012 17:46:56 +0100
Subject: [GIT PULL] LPC32xx fixes for v3.3-rc4
In-Reply-To: <201202271409.52470.arnd@arndb.de>
References: <4F490CC0.5050303@antcom.de> <201202271409.52470.arnd@arndb.de>
Message-ID: <4F4BB380.30803@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Wolfram,

thanks for your notes!

On 02/27/2012 03:09 PM, Arnd Bergmann wrote:
> The patch look all good, but it's not clear where you would like to
> see them applied. The largest one "ARM: LPC32xx: Fix missing and bad
> LPC32XX macros" looks like it is only of cosmetic nature and should
> go into the next/fixes-non-critical branch for v3.4, while the
> others look like they are requried for v3.3

Right. I replaced the mentioned branch with

* lpc32xx/fixes-non-critical (singled out the macros fixes, for next)
* lpc32xx/fixes (the remaining 5 patches as immediate fixes)

Please note that although it's a typo fix in the macros, it's also an
internal API change.

I also added the stable-CC to the "lpc32xx/fixes" and added the note
about NXP's HW bugfix as suggested by Wolfram.

I'll regenerate the pull request. Please tell me if you also like to
have the patches re-posted.

Thanks in advance,

Roland
