From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 31 Mar 2013 09:37:52 +0200
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <1838509461.25809.1364682678664.JavaMail.apache@mail83.abv.bg>
References: <1838509461.25809.1364682678664.JavaMail.apache@mail83.abv.bg>
Message-ID: <20130331073752.GB13159@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

>  >You can do without ret variable... Also more detailed changelog would
>  >be nice... like what exact problem this works around.
>  >
> 
> Sure i can, but I don't see a reason to ignore SM's return value. Changelog of what?
> 
> I guess if you read the thread over the ML you'll have your questions already answered. 
> Or google for "ARM errata 430973 workaround" :).

I did my googling. But I should not have had to. Just put the
explanatory link in commit log.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
