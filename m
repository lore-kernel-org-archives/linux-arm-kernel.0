From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:08:44 -0500
Subject: [PATCH 10/19] watchdog: bindings: Remove obsolete platforms from
 dt doc.
In-Reply-To: <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160923150844.GE9176@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 02:27:48PM +0100, Peter Griffin wrote:
> STiH415/6 SoC support is being removed from the kernel
> so update the dt bding document to reflect this.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <wim@iguana.be>
> Cc: <linux@roeck-us.net>
> Cc: <robh+dt@kernel.org>
> Cc: <linux-watchdog@vger.kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
