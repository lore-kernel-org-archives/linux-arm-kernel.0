From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 21:28:19 +0200
Subject: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
In-Reply-To: <6720864.e2sjvVVhdQ@wuerfel>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
 <6720864.e2sjvVVhdQ@wuerfel>
Message-ID: <CACRpkdZvUh0Z0kxu+WmvwqH3kuaOxaP1Cgxv0WUE2PT-eLs62w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 12:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I don't see any hard dependency here, so I'd suggest to merge the
> two cpufreq patches through the subsystem tree, and the ARM patches
> through arm-soc.

That's right, Viresh can you merge patches 1 and 5 to the
cpufreq tree please?

I will funnel patches 2, 3 and 4 to ARM SoC.

Yours,
Linus Walleij
