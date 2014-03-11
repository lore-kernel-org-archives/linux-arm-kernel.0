From: tj@kernel.org (Tejun Heo)
Date: Tue, 11 Mar 2014 08:49:43 -0400
Subject: [PATCH v15 3/3] arm64: Add APM X-Gene SoC AHCI SATA host
 controller DTS entries
In-Reply-To: <1394059489-30706-4-git-send-email-lho@apm.com>
References: <1394059489-30706-1-git-send-email-lho@apm.com>
 <1394059489-30706-2-git-send-email-lho@apm.com>
 <1394059489-30706-3-git-send-email-lho@apm.com>
 <1394059489-30706-4-git-send-email-lho@apm.com>
Message-ID: <20140311124943.GD11477@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 03:44:49PM -0700, Loc Ho wrote:
> This patch adds APM X-Gene SoC AHCI SATA host controller DTS entries.

I pulled the phy branch into libata/for-3.15 but this patch fails to
apply.  Can you please regenerate the patches which need to be applied
on top of libata/for-3.15.

Thanks.

-- 
tejun
