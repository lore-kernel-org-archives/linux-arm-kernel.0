From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 18:32:54 +0100
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <CAOesGMhQJ65B1FT15Wivm3=n_TvvTDgisq+6MjXHWF6OfQGuTg@mail.gmail.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
 <1375805993.12043.80.camel@hornet>
 <CAOesGMiTr1bTE_A=DGrgMQQd3sN9+E6HbahSHKJpOSfouLqHnQ@mail.gmail.com>
 <1375808629.12043.95.camel@hornet>
 <CAOesGMhQJ65B1FT15Wivm3=n_TvvTDgisq+6MjXHWF6OfQGuTg@mail.gmail.com>
Message-ID: <1375810374.12043.104.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 18:25 +0100, Olof Johansson wrote:
> > I dare to disagree. And the reason is simple - arch/arm64. It's vexpress
> > as well, and we'll be in the same position.
> 
> Actually, no -- PSCI will be mandatory there so there will be no need
> to have these kernel components.

Oh, SPC must die with TC2, no argument from me here. That's why I don't
really mind it being in arch/arm/mach-vexpress today. If it turns out
that it's the last and only thing there, we can discuss it again.

Pawe?
