From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Jan 2015 00:23:42 +0800
Subject: [PATCH 0/2] regulator: axp20x: Migrate to regulator core's simplified
 DT parsing code
Message-ID: <1420820624-10275-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Liam,

This series adapts the axp20x regulator code to use the new simplified
DT parsing code in the regulator core.

The first patch fills in the required regulator descriptor fields for
the DT parsing code.

The second patch removes the original parsing code and switches to 
the regulator core version.

Please have a look.


Regards,
ChenYu


Chen-Yu Tsai (2):
  regulator: axp20x: Fill regulators_node and of_match descriptor fields
  regulator: axp20x: Migrate to regulator core's simplified DT parsing
    code

 drivers/regulator/axp20x-regulator.c | 93 ++++++++++++++----------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

-- 
2.1.4
