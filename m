From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Mar 2013 15:39:24 +0100
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <20130306204557.3ff80000@skate>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
 <20130306204557.3ff80000@skate>
Message-ID: <20130307143924.GA7344@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-03-06 20:45:57, Thomas Petazzoni wrote:
> Dear Pavel Machek,
> 
> On Wed, 6 Mar 2013 20:33:32 +0100, Pavel Machek wrote:
> 
> > Moves dtb files from arch/arm/boot/ to arch/arm/boot/dtb. That causes
> > several problems:
> > 
> > 1) it is inconsistent with 3.8, making switching between 3.9-rc1 and
> > 3.8 tricky
> 
> The commit you're pointing to was part of 3.8, and so the dtb move to
> arch/arm/boot/dts/ is already here since quite a bit of time. At least,
> it's not something you introduced in 3.9-rc1.

Aha, so I guess it changed between 3.7 and 3.8... Anyway, perhaps it
is best to revert it now and treat it as a bug than having everyone
learn that 3.7- has it one way and 3.8+ different?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
