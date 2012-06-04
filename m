From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 4 Jun 2012 16:05:31 +0200
Subject: v3.5-rc1 ARM PXA possible regression
Message-ID: <20120604140531.GA7486@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul

I've got the same problem on my kirkwood based QNAP NAS box.

I bisected it, and the problem patch for me is:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7ff9554bb578ba02166071d2d487b7fc7d860d62

printk: convert byte-buffer to variable-length record buffer

I've not looked further, so i've no idea why this is causing problems.

     Andrew
