From: dwalker@fifo99.com (Daniel Walker)
Date: Fri, 11 Sep 2009 14:04:10 -0700
Subject: [patch] zaurus family: battery cleanups
In-Reply-To: <20090911195635.GD8137@elf.ucw.cz>
References: <20090909073904.GE1327@ucw.cz>
	<1252507631.14793.113.camel@desktop> <20090911195635.GD8137@elf.ucw.cz>
Message-ID: <1252703050.28368.26.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-09-11 at 21:56 +0200, Pavel Machek wrote:
> On Wed 2009-09-09 07:47:11, Daniel Walker wrote:
> > On Wed, 2009-09-09 at 09:39 +0200, Pavel Machek wrote:
> > > This cleans up battery code to conform to codingstyle. The only real
> > > change is that we should now refuse to charge if we can't read battery
> > > temperature.
> > 
> > This patch has a number of checkpatch errors. Mostly trailing
> > whitespace, or just spacing issues..
> 
> Well, original code has problems, too, and I'm trying to slowly clean
> that up.

Ok, but your adding new problems to the code .. So eventually these new
problems would also need to get cleaned up.. If you don't add new
problems and just clean up old problems, then your moving in the right
direction (eventually no problems at all) ..

Daniel
