From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 May 2011 01:56:47 +0200
Subject: [PATCH 2/4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <20110511024709.GA16868@kryptos.austin.rr.com>
References: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
	<20110511024709.GA16868@kryptos.austin.rr.com>
Message-ID: <BANLkTimNO+XBDajGMVNZi-yD0v2ufq-=5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/11 Josh Cartwright <joshc@linux.com>:

>> +out_no_memregion:
>> + ? ? release_mem_region(upmx->phybase, SZ_4K);
>
> release_mem_region(upmx->phybase, upmx->physize); ?

GOOD CATCH!

Thanks Josh!

Linus Walleij
