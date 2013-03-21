From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 21 Mar 2013 14:35:12 -0700
Subject: [PATCH] clk:SPEAr1340: Correct parent clock configuration
In-Reply-To: <CAOh2x=nOgvPzojJ_xCgpCbqkiK4W9ovGm-j5shdjadhfCSOA3g@mail.gmail.com>
References: <9c65c93de3e7269bfc6e31bcdddc2ecd64338761.1362639296.git.vipulkumar.samar@st.com>
 <CAOh2x=nOgvPzojJ_xCgpCbqkiK4W9ovGm-j5shdjadhfCSOA3g@mail.gmail.com>
Message-ID: <20130321213512.834.66394@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2013-03-07 20:42:03)
> On Thu, Mar 7, 2013 at 3:05 PM, Vipul Kumar Samar
> <vipulkumar.samar@st.com> wrote:
> > This patch corrects wrongly configured parent clock for following
> > devices:
> >
> >    * Video enc/decoder
> >    * Video ip
> >    * Pin control
> >    * ACP
> >    * camx
> >
> > Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
> > ---
> >  drivers/clk/spear/spear1340_clock.c |   18 +++++++++---------
> >  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Taken into clk-next.

Thanks,
Mike

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
