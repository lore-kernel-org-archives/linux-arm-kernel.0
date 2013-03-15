From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Mar 2013 13:05:15 -0600
Subject: [PATCH] ARM: tegra: fix register address of slink controller
In-Reply-To: <1363373730-10703-1-git-send-email-ldewangan@nvidia.com>
References: <1363373730-10703-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <514370EB.1030706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2013 12:55 PM, Laxman Dewangan wrote:
> Fix typo on register address of slink3 controller where register
> address is wrongly set as 0x7000d480 but it is 0x7000d800.

Arnd, Olof,

Can you please apply this as a fix for v3.9-rc, and Cc: stable too? Let
me know if you need me to resend the patch to arm at kernel.org to enable this.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Thanks.
