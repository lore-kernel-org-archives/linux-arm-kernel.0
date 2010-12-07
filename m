From: olof@lixom.net (Olof Johansson)
Date: Mon, 6 Dec 2010 19:41:04 -0600
Subject: [PATCH] [2.6.37] ARM: tegra: fix regression from addruart rewrite
In-Reply-To: <AANLkTimAksepMCzuMzqTs53sUx8ErJxzJJZ8POHaqMJs@mail.gmail.com>
References: <20101207013632.GA9379@lixom.net>
	<AANLkTimAksepMCzuMzqTs53sUx8ErJxzJJZ8POHaqMJs@mail.gmail.com>
Message-ID: <20101207014103.GB9379@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 05:40:01PM -0800, Colin Cross wrote:
> On Mon, Dec 6, 2010 at 5:36 PM, Olof Johansson <olof@lixom.net> wrote:
> > 0ea1293009826da45e1019f45dfde1e557bb30df took out the test for
> > MMU on/off but didn't switch the ldr instructions to no longer be
> > conditionals based on said test.
> >
> > Fix that.
> 
> This is fixed in the uart macro consolidation patch I posted yesterday.

Yep, which is scheduled for .38, not .37. I'm actually trying to boot
a mainline kernel instead of the one from the android tree right now,
so I hit this...


-Olof
