From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  7 Mar 2014 12:46:38 +0000
Subject: Renesas clock clk-mstp updates for clock-indices
Message-ID: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, following the commit to add the clock-indices field, the following
pair of commits updates the shmboile clk-mstp driver to uses these over
the local variant.

Since this is involves two separte trees which are in development, the
decision is that we will fixup the renesas trees once they are merged
and the development cycle is complete. Once this is done, patch 2/2
can be reverted (if people care about three lines of differrence)
