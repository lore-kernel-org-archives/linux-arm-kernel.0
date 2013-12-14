From: marex@denx.de (Marek Vasut)
Date: Sat, 14 Dec 2013 06:00:06 +0100
Subject: [PATCH V1 05/11] ARM: dts: imx6qdl-sabrelite: specify pad settings
In-Reply-To: <52ABB815.9030203@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <201312132250.29518.marex@denx.de> <52ABB815.9030203@boundarydevices.com>
Message-ID: <201312140600.06867.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, December 14, 2013 at 02:44:53 AM, Troy Kisky wrote:
> On 12/13/2013 2:50 PM, Marek Vasut wrote:
> > On Friday, December 13, 2013 at 07:42:25 PM, Troy Kisky wrote:
> >> On 12/13/2013 4:48 AM, Marek Vasut wrote:
> >>> On Friday, December 13, 2013 at 02:49:09 AM, Troy Kisky wrote:
> >>>> Don't use 0x80000000 to get default pad settings.
> >>> 
> >>> What is the rationale behind this change please? Can you explain more
> >>> in detail?
> >> 
> >> No real need, but I thought relying on what the boot loader did or did
> >> not do
> >> was discouraged?
> > 
> > Full ACK on this, we do not rely on bootloader configuration (though
> > these two should be in-line).
> > 
> >> What is the value in not explicitly setting the pad registers?
> > 
> > My question was in the direction of "why do you need to change the pin
> > configuration values from the current ones?". This is what I want to
> > understand.
> > 
> >> Btw, I need to rebase series on your patch anyway so omitting this patch
> >> would be easy.
> > 
> > I am not saying to omit it, please do not misunderstand me. I am just
> > wondering why the change from 0x80000000 to 0x1b0b0 .
> > 
> > Best regards,
> > Marek Vasut
> 
> O.K., I'll change the commit log to say exact what is changing, since it
> is very hard to tell
> from the patch. I should have done that without needing the prompt :-)

I am trying to understand what happens here hardware-wise. Is the signal on the 
pins better with this change or what ?

Best regards,
Marek Vasut
