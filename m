From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 12 Jun 2017 14:02:23 +0200
Subject: [PATCH] usb: host: ehci-exynos: Handle return value of
 clk_prepare_enable
In-Reply-To: <3aa745c2cea5b8a91d10f898bc201121001a9a0b.1497265923.git.arvind.yadav.cs@gmail.com>
References: <3aa745c2cea5b8a91d10f898bc201121001a9a0b.1497265923.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170612120223.GA11300@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 04:45:14PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/usb/host/ehci-exynos.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
