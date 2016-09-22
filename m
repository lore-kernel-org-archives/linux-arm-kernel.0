From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Sep 2016 13:51:22 -0700
Subject: Regression in next with "softirq: fix tasklet_kill() and its users"
Message-ID: <20160922205122.ezsxjint2l6lytyi@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Looks like commit 1f5e9c3bc47f ("softirq: fix tasklet_kill() and
its users") causes pandaboard es to not get any IP address on the
smsc95xx USB Ethernet.

Reverting the commits fixes the issue. Any ideas?

Regards,

Tony
