From: mike.turquette@linaro.org (Mike Turquette)
Date: Wed, 21 Nov 2012 12:21:04 -0800
Subject: [PATCH 0/8] CLK: SPEAr: Fixes & updates
In-Reply-To: <CAKohpokjVoNJDPw3xKoaxg3X+7DCycZQjYCNxy-wpq_Y96qYtw@mail.gmail.com>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
 <CAKohpokjVoNJDPw3xKoaxg3X+7DCycZQjYCNxy-wpq_Y96qYtw@mail.gmail.com>
Message-ID: <20121121202104.21126.70266@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2012-11-19 23:34:30)
> On 10 November 2012 12:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi Mike,
> >
> > These are fixes for SPEAr clock stuff. Most of them are fixes, but we don't mind
> > getting them in 3.8.
> >
> > Deepak Sikri (2):
> >   CLK: SPEAr1340: Update clock rate table
> >   CLK: SPEAr: Correct index scanning done for clock synths
> >
> > Rajeev Kumar (1):
> >   CLK: SPEAr: Fix dev_id & con_id for multiple clocks
> >
> > Shiraz Hashim (2):
> >   CLK: SPEAr13xx: Fix mux clock names
> >   CLK: SPEAr13xx: fix parent names of multiple clocks
> >
> > Vipul Kumar Samar (3):
> >   CLK: SPEAr: Set CLK_SET_RATE_PARENT for few clocks
> >   CLK: SPEAr: Add missing clocks
> >   CLK: SPEAr: Remove unused dummy apb_pclk
> 
> Ping!!

Thanks for the re-ping.  I've taken this series into clk-next.

Regards,
Mike
