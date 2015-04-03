From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Apr 2015 10:23:44 +0200
Subject: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
 <20150402203043.GB29963@amd>
 <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
Message-ID: <20150403082344.GA14721@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Hi Pawel,

I'm still Pavel. v, not w.

> > > Hi Pawel,

> > > A corresponding change to the N900 dts would be very nice.
> > 
> > Corresponding change to the dts will come in separate patch. Or do you
> > have n900 for testing?
> 
> Yes, it should be a separate patch, I agree.
> 
> I do have one but I can't say when I'd have time to test it. I'm fine with
> you having tested it though.
> 
> > > I think you're missing change to adp1653_i2c_driver.driver.of_match_table.
> > 
> > It actually worked for me, which means device tree somehow does it
> > magic.
> 
> By magic? :-) It probably just ends up comparing the device and the driver
> names. How about adding the of_match_table?

I guess it uses adp1653_id_table. I'd hade to add redundand
information, because if it would just mask the errors if the code
changed...

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
