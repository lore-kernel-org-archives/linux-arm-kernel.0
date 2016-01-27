From: johannes@sipsolutions.net (Johannes Berg)
Date: Wed, 27 Jan 2016 17:59:34 +0100
Subject: [PATCH v2 0/2] arm/mach-imx: add big-endian support
Message-ID: <1453913976-30619-1-git-send-email-johannes@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add big-endian support for i.MX6, tested on a HummingBoard.

The FEC driver needed adjustements that have already been merged into davem's
net.git, and on 4.5-rc1 regmap is currently broken but Mark Brown is working
on fixing it (or reverting the patch.)

I also compile-tested all the files the patches touch.

johannes
