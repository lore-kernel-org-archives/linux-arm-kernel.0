From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 11 Feb 2011 21:39:45 +0800
Subject: [PATCH v2] i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD
	declaration
In-Reply-To: <19797.13329.366998.503112@ipc1.ka-ro>
References: <1297420916-14505-1-git-send-email-julien.boibessot@free.fr>
	<20110211122505.GB1866@richard-laptop>
	<19797.13329.366998.503112@ipc1.ka-ro>
Message-ID: <20110211133945.GA2282@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 02:05:21PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Richard Zhao writes:
> > Hi Julien,
> > 
> > #define _MX51_PAD_USBH1_DATA2__UART2_TXD	IOMUX_PAD(0x690, 0x290, 1, 0x09ec, 5, 0)
> > 
> > Will you change the above line too?
> > 
> Seems like a general copy/paste error in the i.MX51 Ref Manual.
> For all pads that can have an UART RXD or TXD function the manual
> states that the UART*_IPP_UART_RXD_MUX_SELECT_INPUT register must be
> configured, while this is obviously only sensible for the RXD
> function.
Yes, it's for RXD. RXD can also select input from TXD.

Thanks
Richard
> 
> 
> Lothar Wa?mann
> -- 
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
