From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 17 Jan 2014 14:56:31 -0800
Subject: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
In-Reply-To: <CAFt19AB2Yk4U06-R9rMqFgEHFjN_L-pnc1wR35SQUjX28j7tZQ@mail.gmail.com>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
 <002b01cf1115$4cdfe240$e69fa6c0$%jun@samsung.com>
 <86sism7iuz.fsf@void.printf.net>
 <CAFt19AB2Yk4U06-R9rMqFgEHFjN_L-pnc1wR35SQUjX28j7tZQ@mail.gmail.com>
Message-ID: <20140117225631.4167.47840@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Seungwon Jeon (2014-01-17 08:10:23)
> On Sat, Jan 18, 2014 at 12:01 AM, Chris Ball <chris@printf.net> wrote:
> >
> > Hi,
> >
> > On Tue, Jan 14 2014, Seungwon Jeon wrote:
> > > On Monday, January 13, 2014, Zhangfei Gao wrote:
> > >> Remove clk_table and directly use ios->clock as clock source rate.
> > >> Abstract init clock rate and max clock limitation in clk.c
> > >>
> > >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > >
> > > Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> >
> > It looks like patch 1/2 did not make 3.14.  Do you want me to take
> > this patch for 3.14 anyway?  (Why?)
> Yes, I hope that it would be merged this time.
> I think that this change should have been applied to (036f29: mmc:
> dw_mmc: add dw_mmc-k3 for k3 platform) originally.

Oops, I just read this mail. I have taken in patch #1 through the clk
tree but have not yet pushed it out to my public mirror.

Chris, I'm happy to take it if you haven't yet.

Regards,
Mike

> 
> Thanks,
> sw-j
