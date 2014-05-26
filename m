From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 26 May 2014 11:40:03 +0200
Subject: [PATCH] ARM: dts: imx6qdl-gw5xxx: Fix Linear Technology vendor
 prefix
In-Reply-To: <20140526110830.72eab28a@ipc1.ka-ro>
References: <1401093631-18467-1-git-send-email-p.zabel@pengutronix.de>
 <20140526110830.72eab28a@ipc1.ka-ro>
Message-ID: <1401097203.3400.8.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Am Montag, den 26.05.2014, 11:08 +0200 schrieb Lothar Wa?mann:
> Hi,
> 
> Philipp Zabel wrote:
> > The vendor prefix for Linear Technology should be lltc,
> > same as the NASDAQ symbol.
> > 
> The vendor prefix seems to be missing in
> Documentation/devictree/bindins/vendor-prefixes.txt, or am I missing
> something?

I have sent the documentation patches together with the ltc3589
regulator driver:
https://lkml.org/lkml/2014/5/26/98

regards
Philipp
