From: eric.miao@canonical.com (Eric Miao)
Date: Sat, 4 Sep 2010 16:52:57 +0800
Subject: [PATCH 5/7] ARM: don't expose CONFIG_ZRELADDR to the users
In-Reply-To: <20100903185356.GD17152@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTikg-A7Y19vU+gShPP+zQHpNm-Wzi-m43_dm+OxL@mail.gmail.com>
	<20100903185356.GD17152@pengutronix.de>
Message-ID: <AANLkTikvhJRJNOczM+n21mup+yc-VJS6OyNANUiM=x7U@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/4 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Sep 03, 2010 at 09:30:50PM +0800, Eric Miao wrote:
>> 2010/9/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> >
>> > This value is essential for booting a zImage and only depends on the
>> > memory layout of the machine to boot. ?This value was specified in
>> > Makefile.boot before
>> >
>> > ? ? ? ?e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)
>> >
>> > and so wasn't available to change via .config.
>> >
>> > The only exception is bcmring that had a extra config for specifing the
>> > address used, which is removed in this commit, too, as it isn't used
>> > anymore since e69edc79. ?This is the only machine that still gets a
>> > possibility to change CONFIG_ZRELADDR.
>>
>> This looks correct to me.
> That's an Ack?
>

Ack.
