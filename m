From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 10:48:50 +0100
Subject: [PATCHv3 0/5] ARM: mvebu: no I/O coherency on non-SMP and
 related updates
In-Reply-To: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141113104850.14ce9c0c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 13 Nov 2014 10:38:55 +0100, Thomas Petazzoni wrote:

> This series makes a number of updates to the I/O coherency code of
> Marvell EBU platforms.

Jason, I forgot to mention that this series is based on top of the
mvebu/fixes branch, since this branch contains the "ARM: mvebu: add
missing of_node_put() call in coherency.c" commit.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
