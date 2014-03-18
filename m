From: tj@kernel.org (Tejun Heo)
Date: Tue, 18 Mar 2014 16:06:52 -0400
Subject: [PATCH] ata: Fix compiler warning with APM X-Gene host
 controller driver
In-Reply-To: <1395166477-26408-1-git-send-email-lho@apm.com>
References: <1395166477-26408-1-git-send-email-lho@apm.com>
Message-ID: <20140318200652.GA32357@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 12:14:37PM -0600, Loc Ho wrote:
> This patch fixes an compiler warning with APM X-Gene host controller
> driver when compiled with DEBUG enabled.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
