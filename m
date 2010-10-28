From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 28 Oct 2010 11:06:13 +0900
Subject: [PATCH 8/9] ARM: S5PV210: I2S: Upgrade platform device
In-Reply-To: <20101026183151.GD11207@opensource.wolfsonmicro.com>
References: <1288057274-25603-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikk_Y-VnNKLVGmVZA4iR0+ZTE0u-Scms0TWMbhq@mail.gmail.com>
	<20101026030040.GA10200@opensource.wolfsonmicro.com>
	<023501cb74bf$c8e61ad0$5ab25070$%kim@samsung.com>
	<20101026183151.GD11207@opensource.wolfsonmicro.com>
Message-ID: <AANLkTiky+NsHwaJr+W4NMKs4gAeh_vHhxzKEzZdzGhNZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 3:31 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 26, 2010 at 12:42:13PM +0900, Kukjin Kim wrote:
>
>> Anyway Mark, as you know we have no much time to merge for this merge
>> window.
>> So...if you don't mind, I'd like to apply current style now...then I think
>> we can cleanup it during -rc.
>
> I'm OK with the arch/arm side
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but note that the sound/soc side is probably going to have to wait for
> 2.6.38 as Takashi has already done the ALSA merge with Linus (unless we
> do an additional merge later on).

OK, I think I'll survive one release cycle :)
Any action item on my part before you accept the series to for-2.6.38 ?
