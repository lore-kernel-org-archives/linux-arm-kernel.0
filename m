From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 15:27:01 -0400
Subject: [PATCH V3 1/6] arm: cache-l2x0: make outer_cache_fns a field
 of l2x0_of_data
In-Reply-To: <1346852677-5381-2-git-send-email-gregory.clement@free-electrons.com>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120909192701.GE4575@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 03:44:32PM +0200, Gregory CLEMENT wrote:
> Instead of having multiple functions belonging to outer_cache and
> filling this structure on the fly, use a outer_cache_fns field inside
> l2x0_of_data and just memcopy it into outer_cache depending of the
> type of the l2x0 cache. For non DT case, the former code was kept.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
> 
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>

Applied to:

git://git.infradead.org/users/jcooper/linux.git arm/cache-l2x0

On the advise of Will Deacon, sending through rmk's tree.

thx,

Jason.
