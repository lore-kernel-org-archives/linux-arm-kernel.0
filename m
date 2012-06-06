From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Jun 2012 14:27:34 +0800
Subject: [PATCH v3 00/12] add imx usb driver for mx28/6x
In-Reply-To: <20120606060348.GD32345@arwen.pp.htv.fi>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
 <20120605150209.GZ28631@arwen.pp.htv.fi>
 <20120606022714.GA2667@S2101-09.ap.freescale.net>
 <20120606060348.GD32345@arwen.pp.htv.fi>
Message-ID: <CAAQ0ZWQATu+grzkpy=TLVSbqTGDScj=Zp-zMfwNu1E4=55s0vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2012 14:03, Felipe Balbi <balbi@ti.com> wrote:
> Yes, sure but the whole series is very "coupled" together... Maybe
> Richard could try to split this series into things that can go through
> arm-soc with no dependency on the other part and things that depend on
> drivers/usb/*
>
As far as arch/arm patches applying concerned, I haven't seen any
dependency on drivers/usb part.  If those patches can be applied on
arm-soc tree and do not break anything, that's good enough.  For usb
to actually function, we will need to wait usb and arm-soc trees get
together somewhere, firstly linux-next, eventually mainline.

Regards,
Shawn
