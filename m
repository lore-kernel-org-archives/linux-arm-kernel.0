From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 18 Apr 2011 19:24:28 +0200
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <07919bf9-f05f-ca1c-c084-c4ee18a9dc58@me.com>
References: <20110418135243.GB1479@ucw.cz>
	<07919bf9-f05f-ca1c-c084-c4ee18a9dc58@me.com>
Message-ID: <20110418172427.GA7246@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

(don't top post)

> I'm not 100% sure, but a lot of people made good experience with JFFS2.

jffs2 needs raw flash. CF & SD look like block devices.
 
> Is it that hard to get a log structured file system power fail safe?

Not that bad if you can access raw flash. Very bad if there's layer
that hides flash from you and corrupts data in between...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
