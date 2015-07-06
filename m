From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Jul 2015 19:26:31 +0200 (CEST)
Subject: [PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state'
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <alpine.DEB.2.11.1507061925080.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jul 2015, Viresh Kumar wrote:
> Following patches:
>   ARM/ks8695/time: Migrate to new 'set-state' interface
>   ARM/omap1/time: Migrate to new 'set-state' interface
> 
> must be integrated to mainline kernel via clockevents tree, because of
> dependency on:
>   352370adb058 ("clockevents: Allow set-state callbacks to be optional")

That's bad. We really should get that commit into 4.2 and be done with
it. I was expecting it to show up before rc1 as a pull request, but
obviously that did not happen. We still can get it in.

Thanks

	tglx
