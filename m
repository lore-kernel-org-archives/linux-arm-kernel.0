From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 15:42:35 +0100
Subject: BUG() issues with big-endian
Message-ID: <1374763357-4893-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following Dave Martin's point over the is_valid_bugaddr() it was
found that both is_valid_bugaddr() is broken w.r.t to BE8 as well
as the BUG() macro creation. These two patches fix the problems.
