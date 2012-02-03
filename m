From: jkosina@suse.cz (Jiri Kosina)
Date: Fri, 3 Feb 2012 23:17:53 +0100 (CET)
Subject: [PATCH] [trivial] media: Fix typo in mixer_drv.c and
 hdmi_drv.c
In-Reply-To: <CAH9JG2USF-FYX0SL-y0Gby8oNvA=sFBV7uyvP+4oaa1nxRU5qA@mail.gmail.com>
References: <1327841453-1674-1-git-send-email-standby24x7@gmail.com>
 <CAH9JG2USF-FYX0SL-y0Gby8oNvA=sFBV7uyvP+4oaa1nxRU5qA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1202032317420.25026@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jan 2012, Kyungmin Park wrote:

> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied, thanks.

> > Correct typo "sucessful" to "successful" in
> > drivers/media/video/s5p-tv/mixer_drv.c
> > drivers/media/video/s5p-tv/hdmi_drv.c
> >
> > Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> > ---
> >  drivers/media/video/s5p-tv/hdmi_drv.c  |    4 ++--
> >  drivers/media/video/s5p-tv/mixer_drv.c |    2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/video/s5p-tv/hdmi_drv.c
> > b/drivers/media/video/s5p-tv/hdmi_drv.c
> > index 8b41a04..3e0dd09 100644
> > --- a/drivers/media/video/s5p-tv/hdmi_drv.c
> > +++ b/drivers/media/video/s5p-tv/hdmi_drv.c
> > @@ -962,7 +962,7 @@ static int __devinit hdmi_probe(struct platform_device
> > *pdev)
> >  	/* storing subdev for call that have only access to struct device */
> >  	dev_set_drvdata(dev, sd);
> >
> > -	dev_info(dev, "probe sucessful\n");
> > +	dev_info(dev, "probe successful\n");
> >
> >  	return 0;
> >
> > @@ -1000,7 +1000,7 @@ static int __devexit hdmi_remove(struct
> > platform_device *pdev)
> >  	iounmap(hdmi_dev->regs);
> >  	hdmi_resources_cleanup(hdmi_dev);
> >  	kfree(hdmi_dev);
> > -	dev_info(dev, "remove sucessful\n");
> > +	dev_info(dev, "remove successful\n");
> >
> >  	return 0;
> >  }
> > diff --git a/drivers/media/video/s5p-tv/mixer_drv.c
> > b/drivers/media/video/s5p-tv/mixer_drv.c
> > index 0064309..a2c0c25 100644
> > --- a/drivers/media/video/s5p-tv/mixer_drv.c
> > +++ b/drivers/media/video/s5p-tv/mixer_drv.c
> > @@ -444,7 +444,7 @@ static int __devexit mxr_remove(struct platform_device
> > *pdev)
> >
> >  	kfree(mdev);
> >
> > -	dev_info(dev, "remove sucessful\n");
> > +	dev_info(dev, "remove successful\n");
> >  	return 0;
> >  }

-- 
Jiri Kosina
SUSE Labs
