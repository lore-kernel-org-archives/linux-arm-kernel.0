From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 7 May 2013 11:52:38 +0200
Subject: How does commit 47ec340c not introduce a bug?
In-Reply-To: <CAN1soZyHx1XZzukunbKsj+v4h93MRQKjPPjJ3+i3u8BeBbhCGw@mail.gmail.com>
References: <20130507091734.GM3658@sgi.com>
 <20130507092428.GK23285@pengutronix.de>
 <CAN1soZyHx1XZzukunbKsj+v4h93MRQKjPPjJ3+i3u8BeBbhCGw@mail.gmail.com>
Message-ID: <20130507095238.GA4387@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 05:35:28PM +0800, Haojian Zhuang wrote:
> > It's probably best to make this:
> >
> > static inline max8925_backlight_dt_init(struct platform_device *pdev,
> >                                 struct max8925_backlight_pdata *pdata)
> > {
> >         return -ENODEV;
> > }
> >
> 
> I've submitted this patch to fix this issue for a long time.
> 
> Samuel,
> 
> Should I send it again?
To the backlight maintainers, yes. I carried 47ec340c as it was part of an MFD
patchset, but now that it's upstream I shouldn't take any patches for it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
