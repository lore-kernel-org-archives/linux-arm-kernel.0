From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 2 Apr 2015 16:49:01 +0200
Subject: [PATCH] ti-soc-thermal: implement omap3 support
In-Reply-To: <CANOLnOO4J3RQCJZB0ibkGc5KhvPu+Q1f-bwc8mpxKCPRgjw5PQ@mail.gmail.com>
References: <20150103114632.GA21883@amd> <20150118202447.GA29014@amd>
 <20150331084234.GA11712@amd>
 <CANOLnOO4J3RQCJZB0ibkGc5KhvPu+Q1f-bwc8mpxKCPRgjw5PQ@mail.gmail.com>
Message-ID: <20150402144901.GC18125@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +/* Thresholds and limits for OMAP34XX MPU temperature sensor */
> > +static struct temp_sensor_data omap34xx_mpu_temp_sensor_data = {
> > +       .min_freq = 32768,
> > +       .max_freq = 32768,
> > +       .max_temp = -99000,
> > +       .min_temp = 99000,
> 
> This looks mixed up. Also, perhaps use -40000 to 125000 to match the
> table below?

Yes, that looks reasonable, thanks for review. v2 in minute or so.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
