From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 17:46:14 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v3.18
In-Reply-To: <541819FD.5000301@monstr.eu>
References: <541819FD.5000301@monstr.eu>
Message-ID: <201409251746.14540.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 September 2014, Michal Simek wrote:
>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.18
> 
> for you to fetch changes up to 8097171e19bb69f3e2226827440b71ececa5d74f:
> 
>   ARM: zynq: Remove useless L2C AUX setting (2014-09-16 12:55:12 +0200)
> 
> ----------------------------------------------------------------
> arm: Xilinx Zynq cleanup patches for v3.18
> 
> - PM support
> - Fix L2 useless setting

I don't see why this counts as cleanup when you add so much more code
than you remove, but the individual changes all make sense, so I've
pulled it into next/soc.

Sorry for the delay.

	Arnd
