From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 18:02:49 +0200
Subject: [PATCH v4 2/7] vfio: platform: add capability to register a reset
 function
In-Reply-To: <1445615245-31124-3-git-send-email-eric.auger@linaro.org>
References: <1445615245-31124-1-git-send-email-eric.auger@linaro.org>
 <1445615245-31124-3-git-send-email-eric.auger@linaro.org>
Message-ID: <4009334.qMnorDxQCK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 17:47:20 Eric Auger wrote:
> In preparation for subsequent changes in reset function lookup,
> lets introduce a dynamic list of reset combos (compat string,
> reset module, reset function). The list can be populated/voided with
> vfio_platform_register/unregister_reset. Those are not yet used in
> this patch.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
