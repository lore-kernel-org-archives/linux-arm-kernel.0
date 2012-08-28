From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 29 Aug 2012 00:53:01 +0200
Subject: [PATCH 0/1] clk: add DT fixed-factor-clock binding support
Message-ID: <1346194382-11405-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

During the port of the clock common framework for the armada 370/XP, I
need to get "fixed-factor-clock" using the device tree. For this need
I add support DT for "fixed-factor-clock" in the same way that the
existing support for "fixed-rate-clock". It turned out that finally I
didn't need it anymore, but as the code was written and tested, here
it is.

Gregory Clement
