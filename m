From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 18:01:44 +0200
Subject: More build fixes for omapdrm in current -next
Message-ID: <1462982509-342936-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple more errors showed up in linux-next in the last few
days, all because of missing header files. I have not seen these
before, and most configurations appear to be fine. There
must have been an implicit inclusion somewhere before that
just got removed, but I couldn't find it and doing the
explicit #include should always be better here.

Please apply for 4.7 to avoid regressing on randconfig builds.

	Arnd
