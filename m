From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Apr 2018 08:28:00 +0200
Subject: [PATCH 2/6] spi: spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
 function argument
In-Reply-To: <20180416154021.25626-2-s.nawrocki@samsung.com>
References: <CGME20180416154109epcas2p1696b9cdc72403fe5abdd0a2117067c8d@epcas2p1.samsung.com>
 <20180416154021.25626-1-s.nawrocki@samsung.com>
 <20180416154021.25626-2-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPevRoR5fjhXJWgNdc9XvtPT3w6t9d+4gQyza7qyqEHFZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:40 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The channel argument is not used and anyway it could be retrieved from
> the passed driver data structure.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
