From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 2 May 2018 23:32:10 +0200
Subject: Motorola Droid 4 progress, power consumption
In-Reply-To: <20180502194229.GM98604@atomide.com>
References: <20180501183148.GA26996@amd> <20180502144158.GJ98604@atomide.com>
 <20180502191049.ximiyccwfkjqcj7m@devuan>
 <20180502194229.GM98604@atomide.com>
Message-ID: <20180502213210.GA10306@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I also have some hacks to allow configuration of the full
> > voltage. Charging to 4.35V is pretty agressive, and I believe baterry
> > will be damaged less if we only charge to 4.1V.
> 
> That should be based on the PMIC register values that Android
> uses. Worth rechecking for sure, I thought it is higher than
> normal too for the charge voltage.

Actually that part is ok. Android probably charges it to 4.35V, and
battery is designed to handle that... For a year, or two. But I don't need
full capacity at the moment, and perhaps battery will last three years
if it is only charged to 4.1V.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/b7d72c94/attachment.sig>
