From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 21 Jun 2016 09:08:58 -0700
Subject: [PATCH] ARM: keystone: fix missing keystone.h in pm_domain.c
In-Reply-To: <1466510751-23913-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466510751-23913-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <76697156-9e36-a7df-44ca-206e738d8a37@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2016 5:05 AM, Ben Dooks wrote:
> The declaration of keystone_pm_runtime_init() is not included
> from keystone.h in pm_domain.c. Including the file fixes the
> following sparse warning:
>
> arch/arm/mach-keystone/pm_domain.c:37:12: warning: symbol 'keystone_pm_runtime_init' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
Looks good. Will pick it up.

Regards,
Santosh
