From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jun 2014 19:00:37 +0200
Subject: [GIT PULL] nommu fixes for 3.17-rc1
In-Reply-To: <4782912.zqsM5TNPdE@wuerfel>
References: <20140630144355.GH14781@pengutronix.de>
 <4782912.zqsM5TNPdE@wuerfel>
Message-ID: <CACRpkdZkwzEi2fYqRS-6o_EM-BeOS26Z2uS4DwEmaVT+FEW6eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 5:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Your reasoning is that mach-integrator now doesn't work with !MMU any more
> since it selects ARM_PATCH_PHYS_VIRT, and that no other platform uses
> these CPUs. The change to integrator was done as a preparation for
> multiplatform support and probably did not mean to remove support for !MMU
> integrator.

Well actually the !MMU case has probably never really worked on the
Integrator. I never heard of anyone doing that. The only person who ever
mentioned running !MMU tiles (such as the 740 or 94x variants) was Will
Deacon and I don't know if he ever got it anywhere.

However if it is a good testbase for people synthesizing these old non-MMU
ARM cores still and using Linux with them, then it would make sense to
get that into shape and supported I guess? Especially now that the
Integrator machine is soon-ish even multiplatform (famous last words).

So we need some input here ...

Yours,
Linus Walleij
