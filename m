From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue, 21 Oct 2014 11:26:47 +0530
Subject: [PATCH v3 3/6] Documentation: Update documentation for
 UIO_MEM_PHYS_CACHE
In-Reply-To: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
References: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1413871011-4101-4-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates UIO documentation for new mem region
type UIO_MEM_PHYS_CACHE.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 Documentation/DocBook/uio-howto.tmpl |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/DocBook/uio-howto.tmpl b/Documentation/DocBook/uio-howto.tmpl
index bbe9c1f..baa9185 100644
--- a/Documentation/DocBook/uio-howto.tmpl
+++ b/Documentation/DocBook/uio-howto.tmpl
@@ -529,8 +529,9 @@ the memory region, it will show up in the corresponding sysfs node.
 <varname>int memtype</varname>: Required if the mapping is used. Set this to
 <varname>UIO_MEM_PHYS</varname> if you you have physical memory on your
 card to be mapped. Use <varname>UIO_MEM_LOGICAL</varname> for logical
-memory (e.g. allocated with <function>kmalloc()</function>). There's also
-<varname>UIO_MEM_VIRTUAL</varname> for virtual memory.
+memory (e.g. allocated with <function>kmalloc()</function>). There are also
+<varname>UIO_MEM_VIRTUAL</varname> for virtual memory, and
+<varname>UIO_MEM_PHYS_CACHE</varname> for cacheable access to physical memory.
 </para></listitem>
 
 <listitem><para>
-- 
1.7.9.5
