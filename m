From: W.Vanhauwaert@TELEVIC.com (Vanhauwaert Wouter)
Date: Thu, 15 Jun 2017 09:34:51 +0000
Subject: FEC data corruption?
In-Reply-To: <CAOMZO5AVNBCTSABjXhk-WJCXYhONex59swtwcAHQfoc8H45G2A@mail.gmail.com>
References: <VI1PR0701MB27524436487BAFAF14AC92C5F8C30@VI1PR0701MB2752.eurprd07.prod.outlook.com>
 <CAOMZO5AVNBCTSABjXhk-WJCXYhONex59swtwcAHQfoc8H45G2A@mail.gmail.com>
Message-ID: <VI1PR0701MB275293D40C902C4297D14E77F8C00@VI1PR0701MB2752.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: woensdag 14 juni 2017 16:12
> To: Vanhauwaert Wouter
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: FEC data corruption?
> 
> On Wed, Jun 14, 2017 at 10:43 AM, Vanhauwaert Wouter
> <W.Vanhauwaert@televic.com> wrote:
> > Hello
> > I'm trying to do a long-term network test on 2 platforms.
> > One is based on imx6q, the other on imx6ul.
> > imx6q is using linux-fslc, imx6ul is using linux-imx For that, I enabled the
> busybox inetd service with the echo protocol enabled. I'm flooding the
> device with echo requests of 12kiB (0x3000B) Most of the time that goes
> well, but at certain points, the data returned by the platform is corrupted.
> After some research, it looks like the data returned is copied from memory
> address 0 instead of the correct data address. Any idea what can cause this?
> > Here you'll find a screenshot of wireshark showing this behavior:
> > https://snag.gy/S7cBRl.jpg
> 
> Does the problem happen if you run kernel 4.11.5 or 4.12-rc?
> 

At the moment, I'm running the test on the imx6q on kernel 4.11.4 (also linux-fslc repo)
And it seems to run without problems... (I'm already beyond 1 000 000 successful packages, still running).
Do you have any idea which commit would influence this?

Wouter
