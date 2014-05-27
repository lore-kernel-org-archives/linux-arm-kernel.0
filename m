From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 May 2014 22:25:54 +0200
Subject: [PATCH v6 3/7] arm64: Add a description on 48-bit address space
 with 4KB pages
In-Reply-To: <000201cf6dc6$3ed91500$bc8b3f00$@samsung.com>
References: <000201cf6dc6$3ed91500$bc8b3f00$@samsung.com>
Message-ID: <CAMJs5B8MW_Abni2X=+bdywg9zz5JyaEcDmZ+0MLd79Pn1+ZYtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 06:40:44PM +0900, Jungseok Lee wrote:
> This patch adds memory layout and translation lookup information
> about 48-bit address space with 4K pages. The description is based
> on 4 levels of translation tables.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---

Looks reasonable to me:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
