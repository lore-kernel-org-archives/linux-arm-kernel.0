From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 20 Oct 2016 20:57:45 +0300
Subject: [PATCH v2 3/3] mtd: s3c2410: parse the device configuration from
 OF node
In-Reply-To: <1476906725-22613-4-git-send-email-sergio.prado@e-labworks.com>
References: <1476906725-22613-1-git-send-email-sergio.prado@e-labworks.com>
 <1476906725-22613-4-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161020175745.GC7119@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 05:52:05PM -0200, Sergio Prado wrote:
> Allows configuring Samsung's s3c2410 memory controller using a
> devicetree.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  drivers/mtd/nand/s3c2410.c                     | 155 ++++++++++++++++++++++---
>  include/linux/platform_data/mtd-nand-s3c2410.h |   1 +
>  2 files changed, 140 insertions(+), 16 deletions(-)
>


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
