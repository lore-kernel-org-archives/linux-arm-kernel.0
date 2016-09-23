From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 23 Sep 2016 09:44:59 +0200
Subject: [PATCH 0/3] regulator: axp20x: Simplify various code
Message-ID: <cover.1474616699.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series just simplifies a bit the code of the AXP20x driver.
It does not contain any fonctional changes.
It will be used as a base for adding new AXP devices (patches to come).
It applies on linux-next.

Jean-Francois Moine (3):
  regulator: axp20x: simplify poly-phase handling
  regulator: axp20x: simplify the treatment of linked regulators
  regulator: axp20x: simplify device access

 drivers/regulator/axp20x-regulator.c | 114 ++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 54 deletions(-)

-- 
2.10.0
