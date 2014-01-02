From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jan 2014 20:03:24 +0100
Subject: [PATCH 1/2] spi: clps711x: Driver refactor
In-Reply-To: <20140102182549.GF31886@sirena.org.uk>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <201401021846.23488.arnd@arndb.de> <20140102182549.GF31886@sirena.org.uk>
Message-ID: <1466537.jU4x6flQ6J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014 18:25:49 Mark Brown wrote:
> On Thu, Jan 02, 2014 at 06:46:23PM +0100, Arnd Bergmann wrote:
> 
> > I definitely agree with what you say, but please note that Alexander is
> > the only person who ever sends clps711x patches, so there is not much
> > hope of collaboration. I also suspect he's the only one who would
> 
> There's stuff been going in from the people who do generic cleanups and
> updates.

Yes, I meant patches for new clps711x functionality. I saw the cleanups
as well.

> > suffer from accidental breakage, especially since the existing driver
> > is not used anywhere upstream (no instance of platform data, and no
> > DT support).
>
> Right.  On the other hand I really don't want to get into setting bad
> precedents that people then use when they complain that I actually want
> to review their code, that's just going to be more miserable in the long
> run.

Makes sense.

	Arnd
