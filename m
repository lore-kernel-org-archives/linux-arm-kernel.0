From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 17 Feb 2012 08:59:38 -0800
Subject: [PATCH 3/9] ARM/USB: at91/ohci-at91: remove the use of irq_to_gpio
In-Reply-To: <4F3E20CC.5090205@atmel.com>
References: <1329144189-4535-1-git-send-email-nicolas.ferre@atmel.com>
 <fab15f7eaf6622e68e62bc3afa533b12f48ca27e.1329139662.git.nicolas.ferre@atmel.com>
 <4F3E20CC.5090205@atmel.com>
Message-ID: <20120217165938.GB25671@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 10:41:32AM +0100, Nicolas Ferre wrote:
> On 02/13/2012 03:43 PM, Nicolas Ferre :
> > irq_to_gpio() macro will be removed from AT91 GPIO interrupt
> > controller. So we replace it with the use of gpio_to_irq()
> > and a reworked test.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: linux-usb at vger.kernel.org
> 
> Hi Greg,
> 
> I would like to queue this patch through arm-soc git tree (with all AT91
> material of this patch series).
> 
> So, can I have your "Acked-by" on this one?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
