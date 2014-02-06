From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:47:38 +0900
Subject: [PATCH 0/2] sh_sci updates for v3.15
Message-ID: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

for the v3.14 release you asked me to handle merging sh_sci
updates through my renesas tree as there were circular dependencies between
sh_sci and Renesas SoC code.

While I am happy to keep doing this for v3.15 and beyond as the
motivation above no longer exists I assume that you would like
to go back to handling sh_sci patches through your tree.

If that is the case then please consider this series for v3.15.
It consists of two patches that were sitting in my tree but
didn't make the cut for v3.14 (the arm-soc window for that closed
over a month ago).

Otherwise I will queue them, and other sh_sci patches that have been
more recently posted by others, up in my renesas tree.


Laurent Pinchart (2):
  serial: sh-sci: Restrict non-COMPILE_TEST compilation
  serial: sh-sci: Fix compatible string in DT bindings example

 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 +-
 drivers/tty/serial/Kconfig                                      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.5.2
