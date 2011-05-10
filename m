From: avinashhm@ti.com (Avinash.H.M.)
Date: Tue, 10 May 2011 19:12:16 +0530
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
	<BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
	<alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
	<BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
Message-ID: <20110510134216.GG25479@avinash-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 04:25:19PM +0530, Gulati, Shweta wrote:
> Hi,
> 
> On Sat, May 7, 2011 at 3:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 21 Apr 2011, Gulati, Shweta wrote:
> >
> >> Yes, but in current code clk_set_rate of dpll3_m2 -
> >> 'omap3_core_dpll_m2_set_rate'
> >> doesn't update clk.rate, I will submit patch fixing that bug and will
> >> make sure that
> >> set_rate of all clocks should update clk.rate
> >
> > Ping. ?Do you plan to post this soon? ?This should be a trivial patch.
> Sorry for the delay, I will post today.

Hi Shweta ,

To avoid delay, yesterday posted a patch for the same with your signed
off by : 

http://www.spinics.net/lists/linux-omap/msg50776.html

Please verify the patch and if anything is missing, please submit a new
patch.

thanks ,

- Avinash


> > - Paul
> >
> 
> 
> 
> -- 
> Thanks,
> Regards,
> Shweta
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
