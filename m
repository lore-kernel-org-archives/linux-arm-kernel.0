From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 29 Nov 2009 10:16:40 +0100
Subject: [patch] spitz: better voltage-to-percentage conversion
In-Reply-To: <20091127085417.GB27009@n2100.arm.linux.org.uk>
References: <20091127073119.GB1405@ucw.cz>
	<20091127085417.GB27009@n2100.arm.linux.org.uk>
Message-ID: <20091129091639.GA3483@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +
> > +typedef int miliamp_t;
> > +typedef int miliohm_t;
> > +typedef int milivolt_t;
> 
> 'milliamp' 'milliohm' 'millivolt'

Thanks, updated patch follows.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
