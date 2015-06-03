From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 3 Jun 2015 12:50:50 +0100
Subject: [PATCH 2/4] video: fbdev: imxfb: Constify platform_device_id
In-Reply-To: <556EE743.5030405@ti.com>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-2-git-send-email-k.kozlowski.k@gmail.com>
 <20150505082807.GV4047@x1> <556EE743.5030405@ti.com>
Message-ID: <20150603115050.GB12304@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 03 Jun 2015, Tomi Valkeinen wrote:

> Hi Lee,
> 
> On 05/05/15 11:28, Lee Jones wrote:
> > On Sat, 02 May 2015, Krzysztof Kozlowski wrote:
> > 
> >> The platform_device_id is not modified by the driver and core uses it as
> >> const.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> >> ---
> >>  drivers/video/fbdev/imxfb.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Applied, thanks.
> 
> You applied the fbdev changes in this series also, not only the
> backlight changes?

Ah, yes I did.  I assumed they were all due for Backlight.

Would you like me to un-apply the non-Backlight patches?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
