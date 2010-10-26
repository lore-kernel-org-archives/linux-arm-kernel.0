From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Oct 2010 20:00:41 -0700
Subject: [PATCH 8/9] ARM: S5PV210: I2S: Upgrade platform device
In-Reply-To: <AANLkTikk_Y-VnNKLVGmVZA4iR0+ZTE0u-Scms0TWMbhq@mail.gmail.com>
References: <1288057274-25603-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikk_Y-VnNKLVGmVZA4iR0+ZTE0u-Scms0TWMbhq@mail.gmail.com>
Message-ID: <20101026030040.GA10200@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 11:00:34AM +0900, Kyungmin Park wrote:

> Can you unify the word iis vs. i2s? some variables use the 'iis', some
> names use the i2s. As title is i2s. just unify the i2s?

I'd prefer I2S as well, it's vastly more common than IIS (I don't recall
anyone except Samsung ever using that abbreviation).
