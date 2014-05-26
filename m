From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 13:40:21 -0700
Subject: [GIT PULL 1/2] ARM: berlin: DT changes for v3.16
In-Reply-To: <1400565694-1568-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1400565694-1568-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140526204021.GL27093@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 08:01:33AM +0200, Sebastian Hesselbarth wrote:
> Arnd, Kevin, Olof,
> 
> these are the DT related changes for Berlin SoCs. The first real PR after
> the initial support, I hope it is not too late for v3.16.

Not too late -- I've taken my time to merge it in though.

> We had some late but valuable clock binding changes that are killing my
> time schedule as they had some influence on pinctrl too. Anyway, pipelining
> the arm-soc PR is my last option, I either end up with a broken mach-berlin
> or with useless subsystem drivers. I guess it is just the lesson I had to
> learn.

Bootstrapping new platforms might take a couple of releases, and as long
as progress is done in the right direction without new breakage I don't
think there's too much to worry about w.r.t. making sure that everything
lands together. Especially if you can do it without regressions for the
cases where the platform might already have picked up downstream users.

> Anyway, with this in, it should allow us to use a whole bunch of existing
> drivers for common IP in the next cycle.
> 
> Please pull.

Merged into next/dt.


-Olof
