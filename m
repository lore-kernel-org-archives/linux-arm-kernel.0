From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 12 Jan 2014 19:53:37 +0100
Subject: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
In-Reply-To: <52D287B1.3090106@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
 <20140112114717.GA31318@amd.pavel.ucw.cz>
 <52D287B1.3090106@gmail.com>
Message-ID: <20140112185337.GA6810@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Could we get some more descriptive names for the domains?
> 
> They are listed like this in user's manual, e.g. DOMAIN_F, DOMAIN_I,
> DOMAIN_G, etc.

I guessed so. So the manual sucks. Would it be feasible to get it more
descriptive (like "Domain_G (GPU)")?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
