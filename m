From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Mar 2015 16:50:34 -0700
Subject: [PATCH] mtd: clean up whitespace in linux/mtd/map.h
In-Reply-To: <2220416.D2kDyFWh1C@wuerfel>
References: <2266200.3mx7btcFe5@wuerfel>
 <2220416.D2kDyFWh1C@wuerfel>
Message-ID: <20150311235034.GH32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 05:51:55PM +0100, Arnd Bergmann wrote:
> As the only comments I got for the "mtd: cfi: reduce stack size"
> patch were about whitespace changes, it appears necessary to fix
> up the rest of the file as well, which contains the exact same
> mistakes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The two patches can be applied in either order, or this one dropped
> entirely, I don't care as long as the other patch can get merged,
> or get some constructive feedback.

Also applied to l2-mtd.git.

Brian
