From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 01 Mar 2011 13:48:17 -0500
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102251321.09232.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102241024.01437.arnd@arndb.de>
	<AANLkTikWKk0kE=Hh4gfA6Mwt+-65TVFnBcOYy_eRuQfw@mail.gmail.com>
	<201102251321.09232.arnd@arndb.de>
Message-ID: <4D6D3F71.4040605@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-02-25 07:21, Arnd Bergmann wrote:
> On Friday 25 February 2011, Andrei Warkentin wrote:
>> Yup. I understand :-).  That's the strategy I'm going to follow. For
>> page_size-alignment/splitting I'm looking at the block layer now. Is
>> that the right approach or should I still submit a (cleaned up) patch
>> to mmc/card/block.c for that performance improvement.
> 
> I guess it should live in block/cfq-iosched in the long run, but I don't
> know how easy it is to implement it there for test purposes.

I don't think I saw the original patch(es) for this?


-- 
Jens Axboe
