From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 08:16:07 -0700
Subject: [GIT PULL] at91: cleanup and preparation for the move to common
 clk #1
In-Reply-To: <1382105368-415-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Fri, 18 Oct 2013 16:09:28 +0200")
References: <1382105368-415-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <878uxqwqx4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> This is the first AT91 pull-request for 3.13. I delayed the inclusion of
> material for AT91 as I wanted to build this "cleanup" series with the patches
> for moving AT91 to common clock framerowk. Now that the (big) series is nearly
> finished, I can send you the first patches that are targetted at preparing the
> landing...
>
> I plan to build another pull-request for the whole move to common clk framework
> early next week, if I manage to get the appropiate tags from Mike and the DT
> maintainers.
>
> The work that is beginning here is a big step toward AT91 integratin the
> multi-arch movement and removal of a bunch of code that bloats the mach-at91
> directory.
>
> Thanks, best regards,
>
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-cleanup
>
> for you to fetch changes up to 70e389cc7fedc4c279ef28e970658a39adc7dec7:
>
>   MAINTAINERS: Add patterns for DTS files for AT91 (2013-10-16 16:22:56 +0200)
>
> ----------------------------------------------------------------
> First cleanup series for 3.13
> - a little non-urgent fix
> - addition of DT files to MAINTAINERS
> - more important, the splitting of .dtsi files
>   that allows to precisely choose the peripherals
>   that are present for a particular SoC.
>   It is useful for upcoming move to common cloks.
>
> ----------------------------------------------------------------

Pulled into next/cleanup.

Thanks,

Kevin
