From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Jan 2017 10:16:36 +0800
Subject: [PATCH v7 5/5] soc: zte: pm_domains: Add support for zx296718
In-Reply-To: <1483694164-7668-5-git-send-email-baoyou.xie@linaro.org>
References: <1483694164-7668-1-git-send-email-baoyou.xie@linaro.org>
 <1483694164-7668-5-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170109021634.GI20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 05:16:04PM +0800, Baoyou Xie wrote:
> This patch introduces the power domain driver of zx296718
> which belongs to zte's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Jun Nie <jun.nie@linaro.org>

Except the need of PCU_DM_xxx enum (I'm not strong on that,so would
leave it to author's decision), the patch series looks good to me.
I'm going to queue it up for 4.11 after getting Rob's ACK on bindings.
Let me know if anyone has any objections.

Shawn
