From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Tue, 18 May 2010 11:04:01 +0200
Subject: i.MX27 Clock sources
In-Reply-To: <20100518075109.GC1749@www.longlandclan.yi.org>
References: <20100518075109.GC1749@www.longlandclan.yi.org>
Message-ID: <19442.22529.98355.153495@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> 	For our application, it is necessary to interface this device to
> a Texas Instruments TLV320AIC3204 CODEC.  The i.MX27 provides the clock
> via SSI3_CLK, and communicates using I?S and I?C.  I understand that the
> clock divider for the SSIs is driven from either MPLL or SPLL; but what
> I'm not certain on is where those are configured in the Linux kernel, or
> what the implications are for tinkering with these.
> 
> 	Ideally I'd like to adjust MPLL/SPLL and/or the SSI clocks so
> that the clock rate is some multiple of the I?S bit rate.  So far I can
> get it close; but not close enough.  Does anyone have any pointers as to
> where I can look in the Linux kernel for this information?
> 
Can't you use the codec in master mode, instead of fiddling with the
CPU clocks?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
