From: me@felipebalbi.com (Felipe Balbi)
Date: Tue, 04 Jan 2011 16:56:28 +0200
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <AANLkTi=JyoQuP-OQtV1yO0WR1GCM1LieHUj5Sn=ZfVim@mail.gmail.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com>
	<20110103163447.GB2911@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	<4D220246.5020303@mvista.com>
	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	<20110103204416.GA2240@legolas.emea.dhcp.ti.com>
	<4D231B5F.7030607@mvista.com> <1294149984.1822.9.camel@eowin>
	<AANLkTi=JyoQuP-OQtV1yO0WR1GCM1LieHUj5Sn=ZfVim@mail.gmail.com>
Message-ID: <1294152988.1822.12.camel@eowin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2011-01-04 at 22:40 +0800, Ming Lei wrote:
> > The end goal is just to drop all these ad-hoc "APIs" for accessing DMA
> > on musb code.
> 
> If this kind of DMA controllers are only used by MUSB, seems not
> necessary to convert to dmaengine API.  Any benefit we can get
> from the convert?   MUSB is cross-platform already after all.

<irony>
correct, OMAP GPIO controller is only used on OMAPs, so why do we even
bother having gpiolib, right ?
</irony>

-- 
balbi
