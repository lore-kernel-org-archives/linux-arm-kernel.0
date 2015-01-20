From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 20 Jan 2015 06:11:47 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: print error if wait_target_ready()
 failed
In-Reply-To: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
References: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <alpine.DEB.2.02.1501200611370.5450@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Dec 2014, Lokesh Vutla wrote:

> Fixed pr_debug to pr_err when hwmod returns an error when enabling
> a module.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v3.20 with Roger's ack.


- Paul
