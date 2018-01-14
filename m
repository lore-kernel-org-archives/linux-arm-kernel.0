From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 14 Jan 2018 14:17:24 +0100
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <CACRpkdYtzWewTWrtWTaPWspHzRY6Y7MBNfm1wmy6yvLD_J8hFg@mail.gmail.com>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <20180112020711.6gp2pnsxxjzelidq@localhost>
 <CACRpkdYtzWewTWrtWTaPWspHzRY6Y7MBNfm1wmy6yvLD_J8hFg@mail.gmail.com>
Message-ID: <20180114131724.GN2678@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/01/2018 at 12:17:23 +0100, Linus Walleij wrote:
> On Fri, Jan 12, 2018 at 3:07 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Jan 11, 2018 at 11:28:51AM +0530, Viresh Kumar wrote:
> >> The interrupt-parent of rtc was missing, add it.
> >>
> >> Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
> >> Cc: stable at vger.kernel.org # v3.8+
> >> Reported-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Applied to next/dt. Is stable really needed on this? It's been broken since
> > pretty much forever, and nobody has complained... :)
> 
> The SPEAr architecture is widely used (in modified variants) by
> a large industrial automation company, 20+ years of support cycle.
> 
> However I think they have a forked both kernel and hardware, so they
> will not notice any time soon, and when they eventually upgrade they
> can simply pick the latest I guess.
> 

We have a customer using mainline v4.14 on their Spear600 based
products.

I guess the reason why nobody complained is simply because nobody is
using the SoC RTC ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
