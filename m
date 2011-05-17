From: ivan.nazarenko@gmail.com (Ivan Nazarenko)
Date: Tue, 17 May 2011 14:14:33 -0300
Subject: [PATCH 1/2] mt9p031: Add mt9p031 sensor driver.
In-Reply-To: <BANLkTinR3g7DcXLqOngw8kkNc-LLysFX=w@mail.gmail.com>
References: <1305624528-5595-1-git-send-email-javier.martin@vista-silicon.com>
	<Pine.LNX.4.64.1105171345580.5582@axis700.grange>
	<BANLkTinR3g7DcXLqOngw8kkNc-LLysFX=w@mail.gmail.com>
Message-ID: <201105171414.34179.ivan.nazarenko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

I have been using the aptina patch (https://github.com/Aptina/BeagleBoard-xM) on beagleboard while waiting linux-media solve this mt9p031 issue. Now that you have something working, I would like to try it - but I would like to know what is the clock rate you actually drove the sensor.

Reviewing your path, I suppose it is 54MHz, so you would be achieving some 10 full 5MPix frames/s from the sensor. Is that correct? (the aptina patch delivers less than 4 fps).

Regards,

Ivan

On Tuesday, May 17, 2011 08:59:04 javier Martin wrote:
> On 17 May 2011 13:47, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Hi Laurent
> >
> > Thanks for your review! Javier, if you like, you can wait a couple of days
> > until I find some time to review the driver, or you can submit a version,
> > addressing Laurent's points, but be prepared to have to do another one;)
> >
> > Thanks
> > Guennadi
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> >
> 
> OK, I think I'll wait to have Guennadi's review too.
> Thank you both.
> 
> 
