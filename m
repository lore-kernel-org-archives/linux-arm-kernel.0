From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Oct 2017 13:46:47 +0100
Subject: [GIT PULL] ARM: at91: DT for 4.15
In-Reply-To: <CAK8P3a0ZGHFmMG5Z9Xaa2WfPMTdgN7yAAj7tGH_f__Q5LAwiWw@mail.gmail.com>
References: <20171022195820.hxpzeunexwao26l2@piout.net>
 <CAK8P3a0ZGHFmMG5Z9Xaa2WfPMTdgN7yAAj7tGH_f__Q5LAwiWw@mail.gmail.com>
Message-ID: <20171030124647.ovlshhuusv6aov4q@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/2017 at 13:38:04 +0100, Arnd Bergmann wrote:
> On Sun, Oct 22, 2017 at 9:58 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> >
> > Wenyou Yang (1):
> >       ARM: dts: at91: sama5d2_xplained: Add charger node
> >
> 
> Can you clarify this patch? It looks like an incompatible binding change.
> 

Sort of but not exactly. The DT made it to the mainline but not the
driver (it was working with a driver in the atmel vendor tree though).
When the driver was upstreamed, the binding changed and now we simply
switch to the correct upstream binding.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
