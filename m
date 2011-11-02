From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Nov 2011 20:15:10 +0900
Subject: [PATCH 1/7] SPI: S3C64XX: Use bus clocks created using clkdev
In-Reply-To: <CAAgF-Bf74OJu_OhkJ5vnMoak45ie3VfMxFRjJBO+Swx5o8edXA@mail.gmail.com>
References: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
	<1316778827-24694-2-git-send-email-padma.v@samsung.com>
	<20110923231233.GE24631@ponder.secretlab.ca>
	<003301cc7ca3$3314dae0$993e90a0$%kim@samsung.com>
	<CAAgF-Bf74OJu_OhkJ5vnMoak45ie3VfMxFRjJBO+Swx5o8edXA@mail.gmail.com>
Message-ID: <004901cc9950$af6b73f0$0e425bd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

padma venkat wrote:
> 
> Hi All,
> 
> On Tue, Sep 27, 2011 at 4:52 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> >
> > Grant Likely wrote:
> > >
> > > On Fri, Sep 23, 2011 at 05:23:41PM +0530, Padmavathi Venna wrote:
> > > > This patch modifies the driver to stop depending on the
> > > > clock names being passed from platform and switch over
> > > > to lookup clocks generic names using clkdev
> > > >
> > > > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> > >
> > > Looks okay to me.
> > >
> > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > This series I imagine should go in via the arm-soc tree.
> > >
> > OK, if others ok to me, I will pick up this series so that it will be
sent
> > to upstream via arm-soc.
> 
> Ping.
> Any update on this.
> 

As I said, you need to re-submit others now. Then I will pick this up with
others.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
