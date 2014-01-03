From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 13:52:51 +0100
Subject: [PATCH 1/2] zynq: Do not explicitely enable icache
In-Reply-To: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
References: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
Message-ID: <201401031352.51392.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014, Michal Simek wrote:
> icache is already enabled by default.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  board/xilinx/zynq/board.c | 2 --
>  1 file changed, 2 deletions(-)

You had me confused for a bit. Please mark u-boot patches as such
when you send them to the kernel mailing list, and vice-versa.

	Arnd
