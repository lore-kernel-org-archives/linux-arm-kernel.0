From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Apr 2018 08:30:14 +0200
Subject: [PATCH 4/6] spi: spi-s3c64xx: Do not ignore timeout errors in
 polling I/O mode
In-Reply-To: <20180416154021.25626-4-s.nawrocki@samsung.com>
References: <CGME20180416154130epcas1p492c86e911db645acf32d960281e8b297@epcas1p4.samsung.com>
 <20180416154021.25626-1-s.nawrocki@samsung.com>
 <20180416154021.25626-4-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPc3PGssLjd7CJjiBJBh8hG_agsSsQo-ynNYoQYhQdE=oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:40 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Currently timeout errors in polling I/O mode transfer are silently ignored.
> Fix it by returning an error when we time out waiting on the RX FIFO level
> to reach the transfer length.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
