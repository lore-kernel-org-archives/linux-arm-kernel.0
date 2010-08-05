From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Thu, 5 Aug 2010 14:28:50 +0200
Subject: Patch series For U6/U6715 platform support
Message-ID: <1281011335-25761-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patch series is almost the final one, if no more comment.
I only change the changelog of [PATCH 5/5] to my previous submission.
The 3 first patches are U6715 ARM platform concern only, may be merged
in Russell arm tree.
The 2 latest patches concern the 8250 serial driver, Greg must update
the changelog of patch "U6715 16550A serial driver support" in linux-next
tree and merge the platform U6715 serial driver patch synchronized with
Russell ack (see Andrew previous suggestion). 

Thanks
Philippe
