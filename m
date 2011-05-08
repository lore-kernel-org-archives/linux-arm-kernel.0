From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 May 2011 17:54:14 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTinujj_E4xPvbXB_AQM-d9BqHRts8Q@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105081706.12449.arnd@arndb.de>
	<BANLkTinujj_E4xPvbXB_AQM-d9BqHRts8Q@mail.gmail.com>
Message-ID: <201105081754.14993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 May 2011 17:25:55 Rafa? Mi?ecki wrote:
> 2011/5/8 Arnd Bergmann <arnd@arndb.de>:
> 
> Arnd, right now I'm loosing a lot of time (I could spent on improving
> bcma or b43) on posting new version of this huge patch with single
> changes. Changes that can easily be introduced later without breaking
> driver, ABI, etc.
> 
> I'll be glad to try your solution later, when we get this patch
> merged. I'll be much easier to play with such a differences then.
> Thanks for sharing this idea.
> 
> Right now I want to focus on some bugs in driver that don't allow it
> being merged.

Ok, then I'd suggest leaving out the device strings for now,
you can always add them at a later point.

	Arnd
