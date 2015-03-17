From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 17 Mar 2015 09:48:49 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <B8616E57-51B5-446E-87D5-9C3EC9B5F1C9@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <B8616E57-51B5-446E-87D5-9C3EC9B5F1C9@goldelico.com>
Message-ID: <20150317084849.GB9761@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Temperature calibration should have already been done in the underlaying twl4030 iio driver.
> 
> Discharge rate is the real current flow reported in uA. Also
> reported by iio.

Ack, but there's rather severe temperature dependency of the lithium
battery, which you should take into account if you want to compute
"percentage charged".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
