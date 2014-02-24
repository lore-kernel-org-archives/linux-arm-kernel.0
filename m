From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 12:32:35 -0500
Subject: [PATCH v4 18/22] drivers: Enable building of Kirkwood drivers
 for mach-mvebu
In-Reply-To: <CAKohpo=V6QfinW83L3ohHCijdaMu7PR4bZs=2hrf2GYDfKn1cA@mail.gmail.com>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
 <1393096504-11844-19-git-send-email-andrew@lunn.ch>
 <CAKohpo=V6QfinW83L3ohHCijdaMu7PR4bZs=2hrf2GYDfKn1cA@mail.gmail.com>
Message-ID: <20140224173235.GG14250@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 11:07:35AM +0530, Viresh Kumar wrote:
> On 23 February 2014 00:45, Andrew Lunn <andrew@lunn.ch> wrote:
> > With the move of kirkwood into mach-mvebu, drivers Kconfig need
> > tweeking to allow the kirkwood specific drivers to be built.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Mark Brown <broonie@linaro.org>
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Richard Purdie <rpurdie@rpsys.net>
> > Cc: Bryan Wu <cooloney@gmail.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> > v2
> > Simplify cpufreq/Kconfig.arm
> >
> > Still needs ACKs from cpufreq, led and thermal maintainers.
> > ---
> >  drivers/cpufreq/Kconfig.arm | 2 +-
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Added and pushed, thanks Viresh.

thx,

Jason.
