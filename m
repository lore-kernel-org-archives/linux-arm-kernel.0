From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 20 Dec 2010 14:50:51 +1100
Subject: mc13xxx core support for i2c
Message-ID: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add i2c support for the mc13xxx-core driver. This v3 improves the v2
(http://lists.arm.linux.org.uk/lurker/message/20101215.214755.b6bae366.en.html) by splitting
the driver up into core, spi and i2c files so that it can support one subsystem in the absence
of the other.
