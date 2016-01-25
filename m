From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:44:09 +0100
Subject: [PATCH 0/3] randconfig warning fixes for thermal
Message-ID: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are three simple fixes for ARM randconfig builds:

 [PATCH 1/3] thermal: spear: use __maybe_unused for PM functions
 [PATCH 2/3] thermal: allow spear-thermal driver to be a module
 [PATCH 3/3] thermal: allow u8500-thermal driver to be a module

All three bugs are on configurationsn that are not important and
that rarely happen even with randconfig builds.

	Arnd
