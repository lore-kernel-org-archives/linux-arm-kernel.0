From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 16:41:26 +0100
Subject: [PATCH v2 0/6] serial: 8250: fixes for modular build
Message-ID: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a re-send of three patches I sent a couple of days ago,
with a revert of two patches that Paul did, taking the code in
the opposite direction now, towards ensuring the drivers actually
work as loadable modules, which helps with 'allmodconfig' build
testing.

I've also added another patch for uniphier, and fixed smaller
related issues that came up in further testing.

	Arnd
