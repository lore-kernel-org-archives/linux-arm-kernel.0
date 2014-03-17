From: tj@kernel.org (Tejun Heo)
Date: Mon, 17 Mar 2014 15:55:52 -0400
Subject: [PATCH v18 0/4] ata: Add APM X-Gene SoC AHCI SATA host
 controller support
In-Reply-To: <1394841201-29495-1-git-send-email-lho@apm.com>
References: <1394841201-29495-1-git-send-email-lho@apm.com>
Message-ID: <20140317195552.GC17373@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 05:53:17PM -0600, Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC AHCI SATA host controller. In
> order for the host controller to work, the corresponding PHY driver
> musts also be available. Currently, only Gen3 disk is supported with this
> initial version.

Applied 1-4 to libata/for-3.15.

Thanks.

-- 
tejun
