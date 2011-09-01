From: B19295@freescale.com (Lin Tony-B19295)
Date: Thu, 1 Sep 2011 07:46:37 +0000
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
	from 100ms to 1ms
In-Reply-To: <20110901055522.GB22652@pengutronix.de>
References: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
	<20110901055522.GB22652@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B519DDC6@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Thursday, September 01, 2011 1:55 PM
> To: Lin Tony-B19295
> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> cjb at laptop.org
> Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting
> clock from 100ms to 1ms
> 
> On Thu, Sep 01, 2011 at 01:51:15PM +0800, Tony Lin wrote:
> > 1ms is enough for hardware to change the clock to stable.
> > 100ms is too long.
> 
> How do you know that? Can you be sure for PowerPC as well? Have you
> researched why the original author of the code has chosen that value? If
> so, please update your commit message with such infos.
> 
I got this confirmation by IC simulation, but sorry I just noticed that's also used for PPC.
I can update the information after got confirmation from author. 

> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
