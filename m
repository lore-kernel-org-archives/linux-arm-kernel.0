From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 15:37:02 -0400
Subject: [PATCH V3 6/6] arm: l2x0: add aurora related properties to OF
 binding
In-Reply-To: <1346852677-5381-7-git-send-email-gregory.clement@free-electrons.com>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120909193702.GJ4575@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 03:44:37PM +0200, Gregory CLEMENT wrote:
> Aurora is a L2 Cache Controller designed to be compatible with the
> L2x0 Cache Controller. L2X0 OF bindings are extended to support some
> specificity of Aurora (no cache id part number available through
> hardware, always write through mode, choice between outer cache and
> system cache).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/dt

thx,

Jason.
