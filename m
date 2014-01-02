From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Jan 2014 18:25:49 +0000
Subject: [PATCH 1/2] spi: clps711x: Driver refactor
In-Reply-To: <201401021846.23488.arnd@arndb.de>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <1388583851.810843204@f301.i.mail.ru>
 <20140101150737.GR31886@sirena.org.uk>
 <201401021846.23488.arnd@arndb.de>
Message-ID: <20140102182549.GF31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 06:46:23PM +0100, Arnd Bergmann wrote:

> I definitely agree with what you say, but please note that Alexander is
> the only person who ever sends clps711x patches, so there is not much
> hope of collaboration. I also suspect he's the only one who would

There's stuff been going in from the people who do generic cleanups and
updates.

> suffer from accidental breakage, especially since the existing driver
> is not used anywhere upstream (no instance of platform data, and no
> DT support).

Right.  On the other hand I really don't want to get into setting bad
precedents that people then use when they complain that I actually want
to review their code, that's just going to be more miserable in the long
run.

There were also some things in there that I really did want to review
properly but I wasn't entirely sure what they were actually supposed to
be doing.  Getting things split up with better changelogs will make that
review much more tractable, it might even be immediately obvious what is
going on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/0da08763/attachment-0001.sig>
