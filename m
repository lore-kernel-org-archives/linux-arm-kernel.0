From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 11 Sep 2009 21:56:35 +0200
Subject: [patch] zaurus family: battery cleanups
In-Reply-To: <1252507631.14793.113.camel@desktop>
References: <20090909073904.GE1327@ucw.cz> <1252507631.14793.113.camel@desktop>
Message-ID: <20090911195635.GD8137@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-09-09 07:47:11, Daniel Walker wrote:
> On Wed, 2009-09-09 at 09:39 +0200, Pavel Machek wrote:
> > This cleans up battery code to conform to codingstyle. The only real
> > change is that we should now refuse to charge if we can't read battery
> > temperature.
> 
> This patch has a number of checkpatch errors. Mostly trailing
> whitespace, or just spacing issues..

Well, original code has problems, too, and I'm trying to slowly clean
that up.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
