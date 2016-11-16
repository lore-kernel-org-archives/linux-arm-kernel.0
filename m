From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 16 Nov 2016 18:57:29 +0200
Subject: [PATCH 2/8] ARM: s3c64xx: Add DMA slave maps for PL080 devices
In-Reply-To: <1478791076-19528-3-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <1478791076-19528-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161116165729.GB3727@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:17:50PM +0100, Sylwester Nawrocki wrote:
> This patch adds DMA slave map tables to the pl080 devices's
> platform_data in order to support the new channel request API.
> A few devices for which there was no DMA support with current
> code are omitted in the tables.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/pl080.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
