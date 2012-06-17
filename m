From: olof@lixom.net (Olof Johansson)
Date: Sat, 16 Jun 2012 22:42:49 -0700
Subject: [GIT PULL] Nomadik updates
In-Reply-To: <CACRpkdZtT72EoZTZzu2Ww7Z0CwzdV6EXp_UT+aMeKknSFzKt7g@mail.gmail.com>
References: <CACRpkdZtT72EoZTZzu2Ww7Z0CwzdV6EXp_UT+aMeKknSFzKt7g@mail.gmail.com>
Message-ID: <CAOesGMj4jTj--h46BnDv6=KkEF9NSpgFMGi2tTTkhBMhUVyCCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 9:15 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi ARM SoC maintainers,
>
> could you please pull these Nomadik updates to the ARM SoC tree for
> testing in -next. All patches have been reviewed and ACKed. This
> alters Nomadik so we:
> - Get rid of statically declared devices
> - Support PL031 RTC
> - Support MMC/SD card
> - Convert to use common/generic clock
> - Register the full set of I2C devices on the board
> - Bump IRQs by one avoiding to use IRQ 0 which is now NO_IRQ
>
> The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:
>
> ?Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)
>
> are available in the git repository at:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> nomadik-for-arm-soc

Pulled as nomadik/drivercfg and merged into next/soc. Thanks!


-Olof
