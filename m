From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Oct 2010 11:31:51 -0700
Subject: [PATCH 8/9] ARM: S5PV210: I2S: Upgrade platform device
In-Reply-To: <023501cb74bf$c8e61ad0$5ab25070$%kim@samsung.com>
References: <1288057274-25603-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikk_Y-VnNKLVGmVZA4iR0+ZTE0u-Scms0TWMbhq@mail.gmail.com>
	<20101026030040.GA10200@opensource.wolfsonmicro.com>
	<023501cb74bf$c8e61ad0$5ab25070$%kim@samsung.com>
Message-ID: <20101026183151.GD11207@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 12:42:13PM +0900, Kukjin Kim wrote:

> Anyway Mark, as you know we have no much time to merge for this merge
> window.
> So...if you don't mind, I'd like to apply current style now...then I think
> we can cleanup it during -rc.

I'm OK with the arch/arm side

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but note that the sound/soc side is probably going to have to wait for
2.6.38 as Takashi has already done the ALSA merge with Linus (unless we
do an additional merge later on).
