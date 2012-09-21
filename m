From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Sep 2012 14:23:29 +0100
Subject: [PATCH V4 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <1348213574-18494-4-git-send-email-gregory.clement@free-electrons.com>
References: <1348213574-18494-1-git-send-email-gregory.clement@free-electrons.com>
 <1348213574-18494-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120921132329.GE24613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 08:46:10AM +0100, Gregory CLEMENT wrote:
> Aurora Cache Controller was designed to be compatible with the ARM L2
> Cache Controller. It comes with some difference or improvement such
> as:
> - no cache id part number available through hardware (need to get it
>   by the DT).
> - always write through mode available.
> - two flavors of the controller outer cache and system cache (meaning
>   maintenance operations on L1 are broadcasted to the L2 and L2
>   performs the same operation).
> - in outer cache mode, the cache maintenance operations are improved and
>   can be done on a range inside a page and are not limited to a cache
>   line.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
> 
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> ---

I reviewed this before and it hasn't got any worse since then :)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
