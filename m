From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Thu, 16 Dec 2010 14:16:28 -0800
Subject: [PATCH] OMAP1: clock_data: use runtime cpu / machine checks
In-Reply-To: <alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
References: <201012112150.33831.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.1012130220430.15971@utopia.booyaka.com>
Message-ID: <AANLkTik88QZoNeCKZwUYDjq6oEiiyZE+_fmo+YoE+f85@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 1:24 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello Janusz, Cory,
>
> On Sat, 11 Dec 2010, Janusz Krzysztofik wrote:
>
> > Otherwise multi-omap1 configurations may set wrong clock speed.
> >
> > Created and tested against l-o master on Amstrad Delta.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> Thanks, this is a significant step forward in building a good
> omap1_defconfig. ?Cory, do you mind testing this out? ?If it works for you
> also, let's plan to take this for 2.6.38.
>

Sure, no problem, I'll add it to my testing queue.

- Cory
