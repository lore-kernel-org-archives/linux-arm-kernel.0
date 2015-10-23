From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 15:09:25 +0200
Subject: [PATCH v3 4/7] vfio: platform: reset: calxedaxgmac: add reset
 function registration
In-Reply-To: <1445603835-14506-5-git-send-email-eric.auger@linaro.org>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
 <1445603835-14506-5-git-send-email-eric.auger@linaro.org>
Message-ID: <9240674.LNN502Hn9c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 14:37:12 Eric Auger wrote:
> This patch adds the reset function registration/unregistration.
> This is handled through the module_vfio_reset_handler macro. This
> latter also defines a MODULE_ALIAS which simplifies the load from
> vfio-platform.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
