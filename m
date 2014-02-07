From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 7 Feb 2014 18:09:46 +0100
Subject: [PATCH v3 0/2] *** SUBJECT HERE ***
Message-ID: <cover.1391792986.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*** BLURB HERE ***

Jean-Francois Moine (2):
  drivers/base: permit base components to omit the bind/unbind ops
  drivers/base: declare phandle DT nodes as components

 drivers/base/component.c | 21 +++++++++++++++++++--
 drivers/base/core.c      | 18 ++++++++++++++++++
 include/linux/of.h       |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
1.9.rc1
