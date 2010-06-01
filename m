From: ben-linux@fluff.org (Ben Dooks)
Date: Tue,  1 Jun 2010 11:36:52 +0100
Subject: VIC dynamic PM
Message-ID: <1275388613-2496-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quick patch that works on s3c6410 to change the vic to use kzalloc()
to allocate devices. I think that other architectures should be able
to use this too, but could other people please check about this?

If it is good for all, then comments on getting it merged for 2.6.36?
