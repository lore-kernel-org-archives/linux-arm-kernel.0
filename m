From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Mon, 23 Sep 2013 13:57:54 +0200
Subject: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <201309231236.27554.marex@denx.de>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de>
 <201309231235.56309.jbe@pengutronix.de> <201309231236.27554.marex@denx.de>
Message-ID: <201309231357.54137.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Monday 23 September 2013 12:36:27 Marek Vasut wrote:
> > [...]
> > I also found an MX28EVK with a touchscreen here and: yes it does not work
> > with the modified driver. But now I'm confused, because of Lothar's
> > statement about the TX28 platform.
> >
> > @Lothar: What kernel revision did you use? I had to go back to 3.9 to get
> > a working kernel on the MX28EVK. More recent vanilla kernels stop working
> > (MMC and network fail here).
>
> Can you fix the SD and Network or at least show the fail log ?

Arrgh. My fault. I used the wrong devicetree. (imx28-m28evk.dt instead of 
imx28-evk.dtb). I still need more coffee...

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
