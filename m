From: rogerq@ti.com (Roger Quadros)
Date: Mon, 29 Dec 2014 11:38:58 +0200
Subject: [PATCH] ARM: OMAP2+: hwmod: print error if wait_target_ready()
 failed
In-Reply-To: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
References: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <54A12132.9010100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/14 14:34, Lokesh Vutla wrote:
> Fixed pr_debug to pr_err when hwmod returns an error when enabling
> a module.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
