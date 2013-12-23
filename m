From: lho@apm.com (Loc Ho)
Date: Sun, 22 Dec 2013 21:50:45 -0800
Subject: [PATCH v6 0/4] ata: Add APM X-Gene SoC SATA host controller
 support
In-Reply-To: <1386834940-30875-1-git-send-email-lho@apm.com>
References: <1386834940-30875-1-git-send-email-lho@apm.com>
Message-ID: <CAPw-ZTn2n-HFa+1nExdEKZ6ETjODFjU4+ts5JxDhnn5dbG3xMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Any comment on v6 SATA host controller driver before I post v7 which
fix the clock DTS entry and etc due to the clock change in v5 of the
PHY driver?

-Loc

On Wed, Dec 11, 2013 at 11:55 PM, Loc Ho <lho@apm.com> wrote:
> This patch adds support for the APM X-Gene SoC SATA host controller. In
> order for the host controller to work, the corresponding PHY driver
> musts also be available.
>
> v6:
>  * Update binding documentation
>  * Change select PHY_XGENE_SATA to PHY_XGENE
>  * Add ULL to constants
>  * Change indentation and comments
>  * Clean up the probe functions a bit more
>  * Remove xgene_ahci_remove function
>  * Add the flush register to DTS
>  * Remove the interrupt-parent from DTS
>
