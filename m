From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Apr 2018 08:28:46 +0200
Subject: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
In-Reply-To: <20180416154021.25626-3-s.nawrocki@samsung.com>
References: <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
 <20180416154021.25626-1-s.nawrocki@samsung.com>
 <20180416154021.25626-3-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPfJcJ2pP=whPj-i55MMr6eZSsR+B0AUXG9ZFyynrO0FbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:40 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The spi pointer argument is not used now so remove it. While at it
> s3c64xx_ prefix is added to the function name.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
