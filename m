From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Apr 2013 10:13:34 +0900
Subject: [PATCH 00/03 v4] ARM: shmobile: r8a73a4 APE6EVM board support
In-Reply-To: <20130329075952.15748.6290.sendpatchset@w520>
References: <20130329075952.15748.6290.sendpatchset@w520>
Message-ID: <20130402011333.GB19813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 04:59:52PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a73a4 APE6EVM board support (V4)
> 
> [PATCH 01/03 v3] ARM: shmobile: APE6EVM base support
> [PATCH 02/03 v2] ARM: shmobile: APE6EVM PFC support
> [PATCH 03/03 v3] ARM: shmobile: APE6EVM LAN9220 support
> 
> This series is V4 of initial support for the APE6EVM board.
> 
> The APE6EVM board makes use of the r8a73a4 SoC and has a
> couple of different I/O devices on board, but with this
> series only support for the SCIFA0 UART and the Ethernet
> chip is included.
> 
> In the future support for more I/O devices will be added as
> incremental feature patches.

Thanks, queued up for v3.10 in the boards branch.
