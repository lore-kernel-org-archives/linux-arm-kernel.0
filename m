From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 18 Mar 2016 10:32:19 +0100
Subject: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
In-Reply-To: <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
References: <20160317212603.GA16651@amd>
 <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
Message-ID: <20160318093219.GA999@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Thu, Mar 17, 2016 at 11:26 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > USB gadget stops working for me on n900, if I merge
> 
> Could you please give us more details?
> Which gadget driver do you use (g_nokia?)

It seems I mis-merged the stuff. Hold on, I'm debugging it some more.

Not g_nokia:

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_SUBSET=y


> > (I have patch in my tree to make USB gadget work when it is not
> > modular).
> 
> So this can be reproduced only on builtin gadget, right?
> 
> BTW, I have N900 and can try to play with it this weekend if you'll
> give us more details.

Thanks! Let me try to debug it, then I'll post .config.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
