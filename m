From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Fri, 27 Apr 2018 14:27:34 +0900
Subject: [PATCH] ASoC: uniphier: remove boilerplate from lisence comment
Message-ID: <20180427052734.3506-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes boilerplate of GPLv2, use only SPDX identifier as
same as other recently ASoC DAI drivers.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/aio-compress.c | 13 -------------
 sound/soc/uniphier/aio-core.c     | 13 -------------
 sound/soc/uniphier/aio-cpu.c      | 13 -------------
 sound/soc/uniphier/aio-dma.c      | 13 -------------
 sound/soc/uniphier/aio-ld11.c     | 13 -------------
 sound/soc/uniphier/aio-reg.h      | 13 -------------
 sound/soc/uniphier/aio.h          | 13 -------------
 7 files changed, 91 deletions(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 4c1027aa615e..17f773ac5ca1 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO Compress Audio driver.
 //
 // Copyright (c) 2017-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 4a218ec90e68..638cb3fc5f7b 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO ALSA common driver.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 2dc27e40c192..80daec17be25 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO ALSA CPU DAI driver.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/clk.h>
 #include <linux/errno.h>
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index ef7bafa8e171..4ec6b65bfb44 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO DMA driver.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index 4c4dd3dd4dee..ab04d3331be9 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -3,19 +3,6 @@
 // Socionext UniPhier AIO ALSA driver for LD11/LD20.
 //
 // Copyright (c) 2016-2018 Socionext Inc.
-//
-// This program is free software; you can redistribute it and/or
-// modify it under the terms of the GNU General Public License
-// as published by the Free Software Foundation; version 2
-// of the License.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
-//
-// You should have received a copy of the GNU General Public License
-// along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #include <linux/module.h>
 
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
index d5ffe436fd8d..45fdc6ae358a 100644
--- a/sound/soc/uniphier/aio-reg.h
+++ b/sound/soc/uniphier/aio-reg.h
@@ -3,19 +3,6 @@
  * Socionext UniPhier AIO ALSA driver.
  *
  * Copyright (c) 2016-2018 Socionext Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef SND_UNIPHIER_AIO_REG_H__
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index f029816052f7..aa89c2f6fa24 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -3,19 +3,6 @@
  * Socionext UniPhier AIO ALSA driver.
  *
  * Copyright (c) 2016-2018 Socionext Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef SND_UNIPHIER_AIO_H__
-- 
2.17.0
