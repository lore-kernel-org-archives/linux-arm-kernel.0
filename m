From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 05 Sep 2014 07:59:14 -0700
Subject: [PATCH] ARM: sunxi: Remove sun4i reboot code from mach directory
In-Reply-To: <1409332787-23923-1-git-send-email-maxime.ripard@free-electrons.com>
 (Maxime Ripard's message of "Fri, 29 Aug 2014 19:19:47 +0200")
References: <1409332787-23923-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <7hoauuyuyl.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Now that the restart code has been merged in the watchdog driver, we don't need
> the restart code in the mach-sunxi directory anymore.
>
> Remove it entirely.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>
> Hi Arnd, Kevin, Olof,
>
> I don't know if this can be considered 3.17 material, but if so, it would be
> great if you could merge it directly.

I don't think it's v3.17 material at this point in the cycle because
it's not a regression fix.

Please add it to your queue for v3.18.

Kevin
