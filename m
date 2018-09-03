From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 3 Sep 2018 08:26:22 -0600
Subject: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Message-ID: <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/18 4:01 AM, Corentin Labbe wrote:
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> Patchs 1-7 should go via the ata tree
> Patchs 8,9 should go via the sunxi tree

Applied 1-7 for 4.20, thanks everyone.

-- 
Jens Axboe
