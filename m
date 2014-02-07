From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  7 Feb 2014 18:20:13 +0000
Subject: imprecise abort behaviour
Message-ID: <1391797214-17142-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the current discussion about enabling the external abort
handling, I would like to get the following patch reviewed to
change the behaviour of imprecise aborts to simply causing the
host to get a warning instead of a fatal signal.
