From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 May 2018 10:40:29 +0200
Subject: [PATCH 1/9] ARM: shmobile: defconfig: Enable MTD command line
 partition parsing
In-Reply-To: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180528084029.xqeguqnnk3e3wuim@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 02:02:49PM +0200, Marek Vasut wrote:
> In preparation for removing MTD partitioning from the DTs and moving
> it over to kernel command line partition parsing, enable the support
> for kernel command line MTD partition parsing.
> 
> The argument for not having MTD partitions in the DT is the same as
> for not having hard drive partitions in DT, neither describes the
> hardware itself, so it shouldn't be in the DT. Furthermore, kernel
> command line MTD partition passing allows greater flexibility in
> case someone decided to repartition the flash, which is well in the
> realm of possibility with these systems.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks, applied.
