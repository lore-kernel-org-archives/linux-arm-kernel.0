From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 12 Mar 2014 08:31:40 -0700
Subject: [PATCH RESEND] usb: at91-udc: fix irq and iomem resource retrieval
In-Reply-To: <532075EC.7060809@atmel.com>
References: <1390488102-8548-1-git-send-email-jjhiblot@traphandler.com>
 <1392210209-22142-1-git-send-email-nicolas.ferre@atmel.com>
 <532075EC.7060809@atmel.com>
Message-ID: <20140312153140.GA8141@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 03:57:48PM +0100, Nicolas Ferre wrote:
> On 12/02/2014 14:03, Nicolas Ferre :
> > From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > 
> > When using dt resources retrieval (interrupts and reg properties) there is
> > no predefined order for these resources in the platform dev resource
> > table. Also don't expect the number of resource to be always 2.
> > 
> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: stable <stable@vger.kernel.org> # 3.4
> 
> Gentle ping, after having resent the patch itself.

It helps if you send it to the correct maintainer, remember,
scripts/get_maintainer.pl is your friend...
