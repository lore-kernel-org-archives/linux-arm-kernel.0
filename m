From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 14:57:50 +0100
Subject: [PATCH 0/3] ARM: omap: randconfig warning fixes
Message-ID: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here are three patches to fix the remaining warnings I get
in OMAP randconfig builds. The problems are all harmless,
and the patches are just shutting up the compiler, but I
think it's still worthwhile to include them to reduce the
noise.

	Arnd
