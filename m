From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Jul 2013 12:32:26 +0200
Subject: On common struct clk in clock framework.
In-Reply-To: <CAM2a4uxMO4JjA-_QS_x+9FB38CYJFWCcYQk-kTc7YXMVuJ91Ug@mail.gmail.com>
References: <CAM2a4uyrX0t-W8hXKROvZgJPSyCY+DaviV-eRVZOhyPx=WNBUw@mail.gmail.com>
 <16151917.X00PMOJFZ6@flatron>
 <CAM2a4uxMO4JjA-_QS_x+9FB38CYJFWCcYQk-kTc7YXMVuJ91Ug@mail.gmail.com>
Message-ID: <2625323.Iy4l3LBv4H@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 of July 2013 10:21:27 mind entropy wrote:
> On Wed, Jul 3, 2013 at 11:37 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > The examples you pointed are not using Common Clock Framework. See
> > Documentation/clk.txt and drivers/clk/ for more information about CCF.
> > 
> > As for s3c24xx, CCF driver for the whole platform is already merged for
> > Linux 3.11.
> > 
> > Best regards,
> > Tomasz
> 
> Thanks TomasZ. I have gone through the docs and was quite confused. I
> will have a look at the merge.

Oops. It seems like s3c24xx clk driver is not merged yet. I don't know why 
I thought it is. Heiko (on CC) has been working on it and I remember seeing 
some patches from him. Sorry for misinformation.

Best regards,
Tomasz

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
