From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Oct 2010 12:47:20 +0900
Subject: [PATCH 8/9] ARM: S5PV210: I2S: Upgrade platform device
In-Reply-To: <20101026030040.GA10200@opensource.wolfsonmicro.com>
References: <1288057274-25603-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikk_Y-VnNKLVGmVZA4iR0+ZTE0u-Scms0TWMbhq@mail.gmail.com>
	<20101026030040.GA10200@opensource.wolfsonmicro.com>
Message-ID: <AANLkTimVbv7ro4Terupi_xc3VxA5TSOwk6HH-4BxQ4Bx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 12:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 26, 2010 at 11:00:34AM +0900, Kyungmin Park wrote:
>
>> Can you unify the word iis vs. i2s? some variables use the 'iis', some
>> names use the i2s. As title is i2s. just unify the i2s?
>
> I'd prefer I2S as well, it's vastly more common than IIS (I don't recall
> anyone except Samsung ever using that abbreviation).

I thought so too, but that would have required even more changes in existing
board init files as well. I tried to keep the number of patches as
less as possible.
But if we are to miss this cycle, maybe I should take time out to do it too.
