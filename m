From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 18 Jan 2013 10:45:15 +0800
Subject: [PATCH v7 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
In-Reply-To: <20130118022337.GA29282@S2101-09.ap.freescale.net>
References: <1358475349-27710-1-git-send-email-peter.chen@freescale.com>
 <1358475349-27710-4-git-send-email-peter.chen@freescale.com>
 <20130118022337.GA29282@S2101-09.ap.freescale.net>
Message-ID: <20130118024513.GB17155@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:23:39AM +0800, Shawn Guo wrote:
> Peter,
> 
> On Fri, Jan 18, 2013 at 10:15:49AM +0800, Peter Chen wrote:
> > As we use platform_device_id for fsl-usb2-udc driver, it needs to
> > change clk connection-id, or the related devm_clk_get will be failed.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> You should have my ACK put after your SoB, since I have provided it
> on v6 of this patch.  It will make balbi's life a little bit easier
> when he applies the patch.
thanks, will do next time
> 
> So again,
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Shawn

-- 

Best Regards,
Peter Chen
