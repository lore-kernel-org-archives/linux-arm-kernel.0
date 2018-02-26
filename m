From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 26 Feb 2018 17:17:41 +0100
Subject: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM PLLs
In-Reply-To: <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-2-jernej.skrabec@siol.net>
 <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
Message-ID: <2662255.10CUWtpM2s@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne ponedeljek, 26. februar 2018 ob 10:38:00 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
> > Some NM PLLs doesn't work well when their output clock rate is set below
> > certain rate.
> > 
> > Add support for that constrain.
> 
> In such a case, you should round the rate to the minimum the clock can
> operate at, and not return an error.

OK.

Best regards,
Jernej
