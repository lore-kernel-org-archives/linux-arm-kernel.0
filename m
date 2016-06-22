From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 22 Jun 2016 17:30:24 +0100
Subject: [PATCH] ARM: hisi: make unexported symbols static
In-Reply-To: <1466512133-31751-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466512133-31751-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <576ABD20.9080804@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 21/06/2016 13:28, Ben Dooks wrote:
> The two functions hix5hd2_set_scu_boot_addr() and
> hip01_set_boot_addr() are not declared or exported
> outside arch/arm/mach-hisi/platsmp.c file. Avoid
> the following warnings by making them static:
> 
> arch/arm/mach-hisi/platsmp.c:142:6: warning: symbol 'hip01_set_boot_addr' was not declared. Should it be static?
> arch/arm/mach-hisi/platsmp.c:106:6: warning: symbol 'hix5hd2_set_scu_boot_addr' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-hisi/platsmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks!
Applied to the hisilicon git tree.

Best Regards,
Wei
