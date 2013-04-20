From: chen.gang.flying.transformer@gmail.com (Chen Gang F T)
Date: Sat, 20 Apr 2013 10:48:40 +0800
Subject: [PATCH] ARM64: kernel: compiling issue: need define readq and
 writeq for driver module using.
In-Reply-To: <201304191413.57424.arnd@arndb.de>
References: <51712975.8030104@asianux.com> <201304191413.57424.arnd@arndb.de>
Message-ID: <51720208.3090605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?19? 20:13, Arnd Bergmann wrote:
> On Friday 19 April 2013, Chen Gang wrote:
>> >   when compiling with allmodconfig, CONFIG_64BIT=y
>> >     the file drivers/base/regmap/regmap-mmio.c will use readq and writeq.
>> > 
>> >   so we need implement these functions.
>> > 
>> > BTW:
>> >   the coding style can not pass ./scripts/checkpatch.pl.
>> >   it seems better to provide additional patch for beautifying code.
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

  thanks.

-- 
Chen Gang

Flying Transformer
