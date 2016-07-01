From: tj@kernel.org (Tejun Heo)
Date: Fri, 1 Jul 2016 11:09:42 -0500
Subject: [PATCH v2] PM / suspend: show workqueue state in suspend flow
In-Reply-To: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
References: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
Message-ID: <20160701160942.GC28719@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 11:05:02AM +0800, Roger Lu wrote:
> If freezable workqueue aborts suspend flow, show
> workqueue state for debug purpose.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Acked-by: Tejun Heo <tj@kernel.org>

Rafael, can you please pick this on up?

Thanks.

-- 
tejun
