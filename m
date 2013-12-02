From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Dec 2013 09:20:15 -0800
Subject: [GIT PULL] at91: fixes 3.13 #2
In-Reply-To: <1385991521-3934-1-git-send-email-nicolas.ferre@atmel.com>
References: <1385991521-3934-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <CAOesGMjbj6kRosx_ToQ64nkaz_XNUs53Q9ScZeGk0BO6wWw1Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 2, 2013 at 5:38 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof, Kevin,
>
> A second round of fixes for 3.13 on top of 3.13-rc1. The main fix of this
> series is the one that reduces the frequency of the i2c IP and avoid to hit
> some nasty hardware bugs. It actually allows to save a little power as well...
>
> Thanks, best regards,
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
>
> for you to fetch changes up to 7093bf2b7195541281cb711e31c027a8d826c6df:
>
>   ARM: at91: fixed unresolved symbol "at91_pm_set_standby" when built without CONFIG_PM (2013-12-02 14:24:40 +0100)

Pulled. Thanks for making sure the patch descriptions are good.


-Olof
