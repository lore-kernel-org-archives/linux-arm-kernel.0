From: john.stultz@linaro.org (John Stultz)
Date: Thu, 10 Jan 2013 11:01:57 -0800
Subject: [GIT PULL] clockevent driver cleanup for 3.9
In-Reply-To: <20130110124132.GA8680@S2101-09.ap.freescale.net>
References: <20130110124132.GA8680@S2101-09.ap.freescale.net>
Message-ID: <50EF1025.9030101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 04:41 AM, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
>
>    Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
>
> are available in the git repository at:
>
>    git://git.linaro.org/people/shawnguo/linux-2.6.git tags/clean-clkevt-3.9
>
> for you to fetch changes up to ab8e73c98749a58c242b187c9799db70cd903157:
>
>    clocksource: use clockevents_config_and_register() where possible (2013-01-10 20:24:30 +0800)
>
> ----------------------------------------------------------------
> As John has showed zero interest to collect clock event driver patches,
> I send both patches through arm-soc tree here.

So ack on it going through the arm-soc tree. I do appreciate the effort 
in making these cleanups!

And to be clear, its not just a matter of my not having interest, but 
more an issue of me wanting the patches to be merged where they are most 
likely to be reviewed and tested by folks who know and have the 
hardware. Even when I've made changes in the clocksource core, and had 
to do similar cleanups across the various architectures, I worked to 
push my patches through the arch trees (even when it takes months upon 
months to get them merged), since I don't want to blindside anyone.

thanks
-john
