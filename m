From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Jun 2013 10:51:42 -0700
Subject: [PATCH v2 0/4] dw_apb_timer: osc as sched_clock, clocks and
 clocksource_of support
In-Reply-To: <CACRpkdZmDWTy=U_rhU9uVXy9N5jEOk6qQingiO5kb+Kc2WkL3w@mail.gmail.com>
References: <201306041136.09566.heiko@sntech.de>
 <201306121055.53685.heiko@sntech.de>
 <CACRpkdZmDWTy=U_rhU9uVXy9N5jEOk6qQingiO5kb+Kc2WkL3w@mail.gmail.com>
Message-ID: <20130612175142.GB2760@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 11:46:37AM +0200, Linus Walleij wrote:
> On Wed, Jun 12, 2013 at 10:55 AM, Heiko St?bner <heiko@sntech.de> wrote:
> 
> > with clocksource_of conversion of picoxcell and socfpga, this series stands on
> > its own. Is anybody going to pick it up?
> 
> I would suggest you send a pull request to the ARM SoC maintainers.
> This is where most clocksource code and refactorings related to
> ARM things come in.

Yeah, or we can pick them up and apply from the list too. Have you collected
all Acked-bys and reposted a final version? If not, cc arm at kenrel.org on the
final posting.


-Olof
