From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 19:01:05 +0800
Subject: [PATCH v6 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
In-Reply-To: <20130117105833.GP10814@arwen.pp.htv.fi>
References: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
 <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
 <20130117105833.GP10814@arwen.pp.htv.fi>
Message-ID: <20130117110104.GO26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:58:33PM +0200, Felipe Balbi wrote:
> On Thu, Jan 17, 2013 at 06:03:17PM +0800, Peter Chen wrote:
> > As we use platform_device_id for fsl-usb2-udc driver, it needs to
> > change clk connection-id, or the related devm_clk_get will be failed.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> do I get Acked-by for this one ?

Acked-by: Shawn Guo <shawn.guo@linaro.org>
