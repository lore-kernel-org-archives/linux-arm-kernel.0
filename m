From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 30 Jun 2015 23:45:37 +0200
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
Message-ID: <55930E01.6070909@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2015 05:17 PM, Rafa? Mi?ecki wrote:
> Our bus should allow defining children nodes as we may want to specify
> devices attached to the bus. This is required e.g. to specify NAND or
> ChipCommon cores and use bus's address and IRQ mappings.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  drivers/bcma/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Rafa? have you solved the IRQ problem? Is it possible to assign all the
sub devices the same IRQ number as the chipcommon core?
