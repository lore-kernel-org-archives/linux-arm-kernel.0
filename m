From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 12:21:16 +0000
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <1294199462.348449.192344022926.1.gpush@pororo>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
Message-ID: <20110118122116.GD9719@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 11:51:02AM +0800, Jeremy Kerr wrote:
> ---
>  arch/Kconfig        |    3 
>  include/linux/clk.h |  164 +++++++++++++++++++++++++++++++++++++++++---
>  kernel/Makefile     |    1 
>  kernel/clk.c        |  102 +++++++++++++++++++++++++++
>  4 files changed, 261 insertions(+), 9 deletions(-)

As we already have drivers/clk/, does it really make sense to spread this
far and wide around the kernel tree by putting it in kernel/ ?
