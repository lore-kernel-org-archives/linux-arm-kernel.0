From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jul 2014 14:39:30 -0700
Subject: [GIT PULL] at91: fixes for 3.16 #2
In-Reply-To: <1405692730-31284-1-git-send-email-nicolas.ferre@atmel.com>
References: <1405692730-31284-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <CAOesGMgp+Zxc5Brwpa8-zSgWpj+jX3XVO8nC3f=Tw-b=_m0hVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 7:12 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof, Kevin,
>
> This is the latest regressions that we found while testing the at91sam9n12 and
> at91sam9x5 platforms following our move to CCF.
> I created a pull-request this time because I have 3 patches: there should be
> no conflict anyway. This tag does not contain the fix that Olof had taken during
> previous -rc cycle on purpose: this way it won't appear twice in the history.
>
> Thanks, best regards,
>
> The following changes since commit 971dc9ce106110745f246337f229013589354536:
>
>   ARM: at91/dt: sam9261: remove slow RC osc (2014-06-25 18:00:17 +0200)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
>
> for you to fetch changes up to e0d69e119fc6bf7cc3c9f791478108c1b925bb2e:
>
>   ARM: at91/dt: add missing clocks property to pwm node in sam9x5.dtsi (2014-07-18 15:56:35 +0200)

Merged, thanks.


-Olof
