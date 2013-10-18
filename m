From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 08:23:41 -0700
Subject: [GIT PULL] at91: dt for 3.13 #1
In-Reply-To: <1382108324-9080-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Fri, 18 Oct 2013 16:58:44 +0200")
References: <1382108324-9080-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <874n8ewqki.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> First AT91 DT-related pull-request for 3.13. These patches will not mess with my other
> "cleanup" pull-request sent today.
> It allows to enable sound on the at91sam9n12ek board.
>
> Thanks, best regards,
>
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-dt
>
> for you to fetch changes up to e483341ce82750a1b526b65b7178213dcf967a7a:
>
>   ARM: at91: remove pinctrl conflict between mmc and SPI for at91sam9g20ek (2013-10-18 16:50:13 +0200)
>
> ----------------------------------------------------------------
> First DT series for 3.13
> - addition of sound for at91sam9n12
> - a little fix for MMC vs. SPI on at91sam9g20ek
>
> ----------------------------------------------------------------

Pulled into next/dt.

Thanks,

Kevin
