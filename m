From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 14 Dec 2014 00:51:31 +0100
Subject: bluetooth: Add hci_h4p driver
In-Reply-To: <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
Message-ID: <20141213235131.GA23566@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > My notes say that Marcel wanted different filenames, but I'd need
> > advice exactly what filenames. I guess platform data supprort should
> > be removed altogether, rather than renamed.
> 
> Yes, the platform support should go away. This should be purely based on DT.
> 
> Can you also start using git format-patch so that patches get a diffstat.

So the rest of filenames look ok?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
