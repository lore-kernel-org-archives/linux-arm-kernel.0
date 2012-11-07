From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2012 14:05:47 +0000
Subject: drivers/staging/ced1401/ced_ioc.c:918 GetTransfer() error:
 potential null dereference 'tx'. (kzalloc returns null)
In-Reply-To: <20121107100525.GA31190@localhost>
References: <20121107100525.GA31190@localhost>
Message-ID: <201211071405.48147.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 November 2012, Fengguang Wu wrote:
> FYI, there are new smatch warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git testing/defconfig-warnings

Thanks for the report. All three should be fixed now.

	Arnd
