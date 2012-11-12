From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 15:21:58 +0000
Subject: [PATCH 00/14] ARM: SPEAr: DT updates
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <201211121521.58766.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 November 2012, Viresh Kumar wrote:
> These are DT updates for SPEAr SoCs. There aren't any fixes that we want to get
> into 3.7-rc* and we are happy with 3.8.
> 
> Please apply them from mail, as i wouldn't be hosting them in my repo.
> 
> Some of the dtbs which use gpiopinctrl have dependency on Linus's pinctrl tree,
> where an earlier update for adding gpiopinctrl node is present.

Hi Viresh,

I tried pulling in patches 2 to 11, but it no longer builds because of the
dependency you mentioned. Can you be more specific which branch I need
to pull in?

If you have non-obvious dependencies, I would actually prefer getting a pull
request. I know you have access to git.linaro.org, so can't you just use that
to send a branch that is known to work and that has the right dependencies
included?

	Arnd
