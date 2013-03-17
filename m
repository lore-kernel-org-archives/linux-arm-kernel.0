From: davem@davemloft.net (David Miller)
Date: Sun, 17 Mar 2013 12:01:40 -0400 (EDT)
Subject: [PATCH] ethernet/tulip: DE4x5 needs VIRT_TO_BUS
In-Reply-To: <1363298204-8014-5-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-5-git-send-email-arnd@arndb.de>
Message-ID: <20130317.120140.1114222806134803996.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Mar 2013 22:56:42 +0100

> The automated ARM build tests have shown that the tulip de4x5 driver
> uses the old-style virt_to_bus() interface on some architectures.
> 
> Alpha, Sparc and PowerPC did not hit this problem, because they
> use a different code path, and most other architectures actually
> do provide VIRT_TO_BUS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
