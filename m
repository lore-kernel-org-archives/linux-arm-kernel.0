From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Aug 2010 13:36:16 +0800
Subject: [PATCH 07/13] [ARM] pxa/z2: Fix flash layout typo
In-Reply-To: <1280373389-32475-7-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-7-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTinph4V9xq7HXgajdSYOeJVLZ2TUoOiFT+SyoLr2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 11:16 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/z2.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 07d8bd8..f0d0228 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -164,7 +164,7 @@ static struct mtd_partition z2_flash_parts[] = {
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.name ? = "U-Boot Environment",
> ? ? ? ? ? ? ? ?.offset = 0x40000,
> - ? ? ? ? ? ? ? .size ? = 0x60000,
> + ? ? ? ? ? ? ? .size ? = 0x20000,
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.name ? = "Flash",
> ? ? ? ? ? ? ? ?.offset = 0x60000,
> --
> 1.7.1
>
>
