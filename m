From: andi@etezian.org (andi at etezian.org)
Date: Tue, 17 Apr 2018 04:12:56 +0900
Subject: [PATCH 4/6] spi: spi-s3c64xx: Do not ignore timeout errors in
 polling I/O mode
In-Reply-To: <20180416154021.25626-4-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154130epcas1p492c86e911db645acf32d960281e8b297@epcas1p4.samsung.com>
 <20180416154021.25626-4-s.nawrocki@samsung.com>
Message-ID: <45e9ba3f14fec85a7c046de9d2f41f17@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 17.04.2018 00:40, Sylwester Nawrocki wrote:
> Currently timeout errors in polling I/O mode transfer are silently 
> ignored.
> Fix it by returning an error when we time out waiting on the RX FIFO 
> level
> to reach the transfer length.

yes, makes sense.

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
