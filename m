From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 17 Oct 2014 11:38:23 +0200
Subject: [PATCH 01/26] ARM: sunxi: Fix GPLv2 wording
Message-ID: <1413538728-17705-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the GPL to GPL/X11 licensing migration, the GPL notice introduced
mentionned the device trees as a library, which is not really accurate. It
began to spread by copy and paste. Fix all these library mentions to reflect
the file that it's actually just a file.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        | 6 +++---
 arch/arm/boot/dts/sun6i-a31.dtsi                | 6 +++---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        | 6 +++---
 arch/arm/boot/dts/sun7i-a20-m3.dts              | 6 +++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 6 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi                | 6 +++---
 arch/arm/boot/dts/sun8i-a23.dtsi                | 6 +++---
 arch/arm/boot/dts/sun9i-a80-optimus.dts         | 6 +++---
 arch/arm/boot/dts/sun9i-a80.dtsi                | 6 +++---
 9 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 8b3cd0907b32..eeed1f236ee8 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -6,18 +6,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 543f895d18d3..e80288e881ec 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 0e7c9f552b58..3de847db7e76 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index ce071417e029..b8e568c55271 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 187729a0b7d8..ed364d5e755e 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -6,18 +6,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f0a75c6523a1..45bb9162f5c7 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 6146ef15efbe..6086adbf9d74 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index f83abab108b9..3a70fdf8877e 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 5e2ec4b71f5b..ae0920f7ce7a 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -8,18 +8,18 @@
  * licensing only applies to this file, and not this project as a
  * whole.
  *
- *  a) This library is free software; you can redistribute it and/or
+ *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
- *     This library is distributed in the hope that it will be useful,
+ *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
+ *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
-- 
2.1.1
