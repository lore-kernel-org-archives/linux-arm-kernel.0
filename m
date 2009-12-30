From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 15:22:40 +0200
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <4B3B5232.5030804@ru.mvista.com>
References: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>
	<20091229125403.GD17147@nokia.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FFF44876@dbde02.ent.ti.com>
	<20091230122441.GA16585@gandalf>  <4B3B5232.5030804@ru.mvista.com>
Message-ID: <1262179360.17250.6.camel@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2009-12-30 at 16:14 +0300, Sergei Shtylyov wrote:
>    We're currently having it there but the matter is it should be shred 
> between different platforms, so arch/arm/common/ seems like the right 
> place (which Russell didn't like, suggesting ill suited for that 
> drivers/dma/ instead).

if it had to be shared between different platforms, it could very well
live under drivers/usb/musb, problem is that it has to be shared among
several devices. Then drivers/usb/musb is not the right place anymore.

-- 
balbi
