From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 16:04:12 -0600
Subject: [PATCH v4 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <1456556396-4759-2-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-2-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <20160303220412.GA27797@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 12:29:54PM +0530, Raveendra Padasalagi wrote:
> In Cygnus SOC touch screen controller registers are shared
> with ADC and flex timer. Using readl/writel could lead to
> race condition. So touch screen driver is enhanced to support
> register access using syscon framework API's to take care of
> mutually exclusive access.In addition to this existing touchscreen
> node name "tsc" is renamed to "touchscreen".
> 
> Hence touchscreen dt node bindings document is updated to take care
> of above changes in the touchscreen driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../input/touchscreen/brcm,iproc-touchscreen.txt    | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
