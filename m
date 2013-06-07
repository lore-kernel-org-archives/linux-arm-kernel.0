From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Fri, 7 Jun 2013 09:21:03 +0200
Subject: mxsfb: DATA_FORMAT_24_BIT flag outputs invalid colours
In-Reply-To: <201305241533.19941.jbe@pengutronix.de>
References: <519E03B0.1080006@digi.com> <519F4435.5010703@digi.com>
 <201305241300.25461.jbe@pengutronix.de>
 <201305241533.19941.jbe@pengutronix.de>
Message-ID: <20130607072103.GF14209@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

On Fri, May 24, 2013 at 03:33:19PM +0200, Juergen Beisert wrote:
> Someone told me, Qt5 cannot handle this special RGB666 mode (even not the 
> def_rgb666_shift memory layout mentioned above). My test are based on Qt4. 
> Qt5 needs a regular RGB888 mode, which should silently be converted 
> internally to RGB666 in the hardware.
> 
> So, your patch to always use the RGB888 memory layout seems to be the right 
> way to go.

Do you plan on submitting this patch? (Or did you already submit it and
I overlooked it?)

Thanks,
Maxime
