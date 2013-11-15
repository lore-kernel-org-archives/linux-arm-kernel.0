From: olof@lixom.net (Olof Johansson)
Date: Fri, 15 Nov 2013 11:14:40 -0800
Subject: [GIT PULL] at91: non-critical fixes for 3.13 #1
In-Reply-To: <1384514665-32174-1-git-send-email-nicolas.ferre@atmel.com>
References: <1384514665-32174-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <CAOesGMhTMxsqeAoGZ0VUSPC4c4i9_g3J38yyQRryRmSGPZ_Xnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 3:24 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof, Kevin,
>
> This is a pull-request for AT91 about non-critical fixes for 3.13. This means
> that you can certainly plan it for early 3.14.
> It is not a 3.13 regression as this issue has been present for ages. I have
> tagged the patch for "-stable" down to 3.11.y as they need modification to
> apply on older kernels.
>
> Thanks, best regards,
>
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes-non-critical
>
> for you to fetch changes up to 94c4c79f2f1acca6e69a50bff5a7d9027509c16b:
>
>   ARM: at91: fix hanged boot due to early rtt-interrupt (2013-11-15 12:13:33 +0100)
>
> ----------------------------------------------------------------
> Fixes for RTT & RTC interrupts that can fire early
> during boot process and kill the system.
> This fix has been discussed for months and it is time
> for it to reach mainline.


It's a bummer that this can't be fixed in firmware instead (since
there's a lot of devices out there with flashed firmware already,
etc).

We're early in the release cycle, and this is marked for -stable, so I
am pulling this into fixes for 3.13. It doesn't make sense to hold off
if it'll have to hit 3.13.y anyway.

So; pulled into fixes.


-Olof
