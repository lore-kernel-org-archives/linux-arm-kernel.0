From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 7 Feb 2014 18:11:08 +0100
Subject: [PATCH RFC 0/2] drivers/base: simplify simple DT-based components
Message-ID: <cover.1391793068.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series tries to simplify the code of simple devices in case
they are part of componentised subsystems, are declared in a DT, and
are not using the component bin/unbind functions.

Jean-Francois Moine (2):
  drivers/base: permit base components to omit the bind/unbind ops
  drivers/base: declare phandle DT nodes as components

 drivers/base/component.c | 21 +++++++++++++++++++--
 drivers/base/core.c      | 18 ++++++++++++++++++
 include/linux/of.h       |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
1.9.rc1
