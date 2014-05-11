From: horms@verge.net.au (Simon Horman)
Date: Sun, 11 May 2014 09:26:24 +0900
Subject: [PATCH] ARM: shmobile: henninger: add QSPI DT support
In-Reply-To: <201405060245.32952.sergei.shtylyov@cogentembedded.com>
References: <201405060245.32952.sergei.shtylyov@cogentembedded.com>
Message-ID: <20140511002624.GS31760@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 02:45:31AM +0400, Sergei Shtylyov wrote:
> Define the Henninger board dependent part of the QSPI device node.
> Add device nodes for Spansion S25FL512S SPI flash and MTD partitions on it.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against 'renesas-devel-v3.15-rc3-20140502' tag of Simon Horman's
> 'renesas.git' repo and SDHI0/2 DT support patch posted last weekend.
> 
>  arch/arm/boot/dts/r8a7791-henninger.dts |   38 ++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Thanks, I have queued this up.
