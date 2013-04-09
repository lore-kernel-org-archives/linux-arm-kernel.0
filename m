From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 20:56:30 +0200
Subject: [PATCH 6/8] dmaengine: ste_dma40: Move LCPA allocation and
 real-time config
In-Reply-To: <1365532783-27425-6-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-6-git-send-email-lee.jones@linaro.org>
Message-ID: <201304092056.31101.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> There are various pieces of configuration which do not need to happen
> until after a channel is allocated. Here we move some of these so they're
> dealt with when it's time to configure the channel, rather than allocate
> it.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
