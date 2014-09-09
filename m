From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue,  9 Sep 2014 15:26:56 +0530
Subject: [PATCH 2/5] Documentation: Update documentation for UIO_MEM_PHYS_CACHE
In-Reply-To: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
References: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1410256619-3213-3-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update UIO documentation for new mem region
type UIO_MEM_PHYS_CACHE.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 Documentation/DocBook/uio-howto.tmpl |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/DocBook/uio-howto.tmpl b/Documentation/DocBook/uio-howto.tmpl
index bbe9c1f..49e47d4 100644
--- a/Documentation/DocBook/uio-howto.tmpl
+++ b/Documentation/DocBook/uio-howto.tmpl
@@ -530,7 +530,8 @@ the memory region, it will show up in the corresponding sysfs node.
 <varname>UIO_MEM_PHYS</varname> if you you have physical memory on your
 card to be mapped. Use <varname>UIO_MEM_LOGICAL</varname> for logical
 memory (e.g. allocated with <function>kmalloc()</function>). There's also
-<varname>UIO_MEM_VIRTUAL</varname> for virtual memory.
+<varname>UIO_MEM_VIRTUAL</varname> for virtual memory and
+<varname>UIO_MEM_PHYS_CACHE</varname> for physical cacheable memory.
 </para></listitem>
 
 <listitem><para>
-- 
1.7.9.5
