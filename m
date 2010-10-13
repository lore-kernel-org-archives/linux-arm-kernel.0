From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Oct 2010 09:25:52 +0100
Subject: [PATCH v2 4/6] ARM: S5P: Add EPLL rate change warning
In-Reply-To: <002801cb6aaf$b19368c0$14ba3a40$%kim@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
	<1286883983-27790-1-git-send-email-sw.youn@samsung.com>
	<002301cb6aac$12a05e10$37e11a30$%kim@samsung.com>
	<20101013080902.GA6424@rakim.wolfsonmicro.main>
	<002801cb6aaf$b19368c0$14ba3a40$%kim@samsung.com>
Message-ID: <20101013082552.GE6424@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 05:21:48PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > Personally I don't think it really makes much odds so long as the
> > message is displayed on the console by default.

> Hmm...yeah I mean just EPLL is used only in the audio and SPI now. However
> we don't know which driver will use it later. And as you said, need to show
> it. Ok...will apply.

FWIW the particular favourite that users run into with some of the CPUs
is USB.
