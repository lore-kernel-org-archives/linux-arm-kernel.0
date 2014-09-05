From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 14:28:45 +0200
Subject: [PATCH 11/19] ARM: S5PV210: Remove support for board files
In-Reply-To: <1409918658.7832.25.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <201409041802.36466.arnd@arndb.de> <1409918658.7832.25.camel@x220>
Message-ID: <16177201.Mk3a7oJAud@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 14:04:18 Paul Bolle wrote:
> 
> On Thu, 2014-09-04 at 18:02 +0200, Arnd Bergmann wrote:
> > I think it would be nice if you could submit a patch to remove the
> > drivers from ASoC, then we can see if anybody complains.
> 
> Just to know what I'm getting my self into: whom would you expect to
> send me agitated messages once those patches have landed?

That would be somebody who is using their own patches on top of
mainline and didn't notice that upstream broke under them ;-)

	Arnd
