From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Tue, 10 May 2011 16:25:19 +0530
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
	<BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
	<alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
Message-ID: <BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 7, 2011 at 3:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 21 Apr 2011, Gulati, Shweta wrote:
>
>> Yes, but in current code clk_set_rate of dpll3_m2 -
>> 'omap3_core_dpll_m2_set_rate'
>> doesn't update clk.rate, I will submit patch fixing that bug and will
>> make sure that
>> set_rate of all clocks should update clk.rate
>
> Ping. ?Do you plan to post this soon? ?This should be a trivial patch.
Sorry for the delay, I will post today.
> - Paul
>



-- 
Thanks,
Regards,
Shweta
