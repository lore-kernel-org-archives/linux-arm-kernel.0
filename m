From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 10 Aug 2016 11:23:16 +0200
Subject: [PATCH] ARM: S3C24XX: Add missing DMA device for Mini2440 board
In-Reply-To: <1470305291-15054-1-git-send-email-s.nawrocki@samsung.com>
References: <1470305291-15054-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPejFjBODNMZJWuskm8uK4M4ZmxJEw6wczVLNEnsWF5YHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2016 at 12:08 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Addition of s3c2440_device_dma was missed during conversion
> from the Samsung legacy to the regular DMa API.
> Add it so any devices using DMA, e.g I2S controller can
> work properly.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks, applied.

BR,
Krzysztof
