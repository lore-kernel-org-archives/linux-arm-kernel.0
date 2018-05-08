From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 08 May 2018 11:19:02 -0700
Subject: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
In-Reply-To: <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon>
 <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
Message-ID: <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stefan Agner (2018-05-08 06:20:03)
> On 08.05.2018 09:32, Jacky Bai wrote:
> > 
> > I have tried two 6ULL board, I don't meet such issue. System can boot
> > up successfully with commit 6f9575e55632 included.
> > Anyway, the change in this patch is ok for me. it is no harm to the
> > BUS clock change flow.
> 
> Hm, that is interesting, maybe it is because we use a different SKU? Or
> maybe bootloader?
> 
> I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL using
> U-Boot 2016.11.
> 

I'll throw this into fixes today because it fixes something to be
useful. It's still interesting to see what's different between the two
setups though.
