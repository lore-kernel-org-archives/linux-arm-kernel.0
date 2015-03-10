From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Mar 2015 16:10:09 -0500
Subject: [PATCHv7 0/4] USB: gadget: atmel_usba_udc: PM driver improvements
In-Reply-To: <54F704D3.5020504@atmel.com>
References: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
 <54F704D3.5020504@atmel.com>
Message-ID: <20150310211009.GC25666@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 02:12:51PM +0100, Nicolas Ferre wrote:
> Le 12/02/2015 18:54, Sylvain Rochet a ?crit :
> > Start clocks on rising edge of the Vbus signal, stop clocks on falling
> > edge of the Vbus signal.
> > 
> > Add suspend/resume with wakeup support.
> 
> Hi Felipe,
> 
> I think this series by Sylvain is ready for inclusion. Are you able to
> take it for the next cycle?

taking it now. Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/67e4e2c5/attachment.sig>
