From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 17:01:02 +0200
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721CDD7B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
	<65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110713140038.GI1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDD7B@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20110713150102.GK1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 02:22:42PM +0000, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> > Sent: Wednesday, July 13, 2011 10:01 PM
> > To: Dong Aisheng-B29396
> > Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> > broonie at opensource.wolfsonmicro.com; u.kleine-koenig at pengutronix.de;
> > lrg at ti.com; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
> > 
> > With your sgtl-patch, I can set the alsa-controls like volume. Yet the
> > WAV played via simple aplay has a massive hall (like a concert at the
> > other end of the cathedral ;)). 
> 
> You mean the sound is incorrect?

It was, but is fixed now. There was something wrong in our audio-path
electrically. Together with your DMA patch, music sounds fine now \o/

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/0525987a/attachment.sig>
