From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 11 Jun 2013 10:09:09 +0530
Subject: [PATCH 2/9] dma: pl330: use dma_addr_t for describing bus
 addresses
In-Reply-To: <1370889285-22799-3-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-3-git-send-email-will.deacon@arm.com>
Message-ID: <CAJe_Zhf2yjKC=SrC0vOx-0VYKs4D9ewKwyM_ip6it7tFM8hQcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 June 2013 00:04, Will Deacon <will.deacon@arm.com> wrote:
> The microcode bus address (pl330_dmac.mcode_bus) is currently a u32,
> which fails to compile when building on a system with 64-bit bus
> addresses.
>
> This patch uses dma_addr_t to represent the address instead.
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
