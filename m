From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Apr 2018 08:27:27 +0200
Subject: [PATCH 1/6] spi: spi-s3c64xx: Remove unused driver data structure
 tgl_spi field
In-Reply-To: <20180416154021.25626-1-s.nawrocki@samsung.com>
References: <CGME20180416154055epcas2p4c08bb2254e79368a29eb481cddc59855@epcas2p4.samsung.com>
 <20180416154021.25626-1-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPcSJoDLAK5VnPbqDq7zVPxr1NCTdd+e8WfTgyOAw=2CYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:40 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The tgl_spi pointer is now unused so remove it.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
