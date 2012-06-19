From: marex@denx.de (Marek Vasut)
Date: Tue, 19 Jun 2012 04:07:31 +0200
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <CAOMZO5C7KaxO_X23Ur9YwHEoAvCPf4emxMzH4mmrFX6=de5GZA@mail.gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <F281D0F91ED19E4D8E63A7504E8A649803BE2DE2@039-SN2MPN1-023.039d.mgd.msft.net>
 <CAOMZO5C7KaxO_X23Ur9YwHEoAvCPf4emxMzH4mmrFX6=de5GZA@mail.gmail.com>
Message-ID: <201206190407.31524.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Peter,
> 
> On Mon, Jun 18, 2012 at 10:14 PM, Chen Peter-B29397
> 
> <B29397@freescale.com> wrote:
> >> Nothing shows up in the console after connecting the stick.
> >> 
> >> Attached my .config file.
> > 
> > Make sure the vbus is on for your usb port.
> 
> So what is the magic needed here? Isn't Richard's series supposed to work
> as is?
> 
> What should be done in addition to Richard's patch in order to get USB
> host to work on mx28evk?

Ah right, you need to toggle the power supply (vbus) GPIO.

Best regards,
Marek Vasut
