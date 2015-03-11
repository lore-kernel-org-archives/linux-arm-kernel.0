From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 11 Mar 2015 10:50:04 +0100
Subject: [PATCHv7 2/4] USB: gadget: atmel_usba_udc: Request an auto
 disabled Vbus signal IRQ instead of an auto enabled IRQ request followed by
 IRQ disable
In-Reply-To: <20150310211214.GD25666@saruman.tx.rr.com>
References: <1423763647-11687-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423763647-11687-3-git-send-email-sylvain.rochet@finsecur.com>
 <20150310211214.GD25666@saruman.tx.rr.com>
Message-ID: <20150311095004.GA1487@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Felipe,

On Tue, Mar 10, 2015 at 04:12:14PM -0500, Felipe Balbi wrote:
> Hi,
> 
> (dropping patch, my only context is subject line)
> 
> "USB: gadget: atmel_usba_udc: Request an auto disabled Vbus signal IRQ
> instead of an auto enabled IRQ request followed by IRQ disable"
> 
> Holy crap, that's a pretty long patch *short* description. I'm trimming
> it to:
> 
> "usb: gadget: atmel_usba_udc: Request an auto disabled Vbus signal IRQ"

I agree, lesson learned!, thanks for the heads up :)

Cheers,
Sylvain
