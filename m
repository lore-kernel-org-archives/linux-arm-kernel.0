From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 10 Feb 2014 10:40:04 -0800
Subject: [GIT PULL] at91: fixes for 3.14 #1
In-Reply-To: <1391790986-31936-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Fri, 7 Feb 2014 17:36:26 +0100")
References: <1391790986-31936-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <7hha8695h7.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> This is a first "fixes" series for AT91 on 3.14.
> The content is only DT-related and quite boring.
> I took the opportunity of this early "fixes" pull-request to collect
> some Documentation patches that were lying around and I guess that
> they can be merged by arm-soc nicely (addition of CCF to 2 drivers).
> A new board is added to the lot because it is dead simple and integrates
> well with the new sama5d36 SoC that we added earlier in this development cycle.
>
> Thanks, best regards,
>
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
>
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
>
> for you to fetch changes up to b7c2b6157079811586180d13c44a1095b57c2d47:
>
>   ARM: at91: add Atmel's SAMA5D3 Xplained board (2014-02-07 17:20:39 +0100)
>
> ----------------------------------------------------------------
> First series of AT91 fixes for 3.14.
> All of them are DT-related.
> - fixes for typos in i2c and ohci clocks
> - addition of a USB host node for at91sam9n12ek
> - 2 DT documentation updates that have been sent a long time ago
> - a new board based on the sama5d36 SoC
>
> ----------------------------------------------------------------

Pulled into fixes,

Thanks,

Kevin
