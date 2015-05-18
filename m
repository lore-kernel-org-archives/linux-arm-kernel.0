From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 May 2015 16:09:35 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: make savedefconfig for removing
 useless configs
In-Reply-To: <55598A56.7020006@kernel.org>
References: <55598A56.7020006@kernel.org>
Message-ID: <5559902F.7040506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.05.2015 15:44, Kukjin Kim wrote:
> This patch removes useless configs which can be seleted according to
> the dependencies in defconfig with using 'make savedefconfig' because
> we don't need to keep them in defconfig file.
> 
> Signed-off-by: Kukjin Kim <kgene@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> ---
> When I tried to sort out exynos related configs for multi_v7_defconfig,
> I found there are many useless configs in there so sending this. If you
> guys OK with this, I'll sort them out including this.

On which tree and commit this is rebased on? I tried next
(next-20150515) and your for-next (v4.1-rc3-34-gfcfae6b049cf) branches
but I does not apply to any of them. Can you point me to base branch?

Best regards,
Krzysztof
