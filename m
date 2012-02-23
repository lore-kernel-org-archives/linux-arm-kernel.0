From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:31 +0000
Subject: [PATCH-WIP 10/13] xen/arm: empty implementation of
 xen_remap_domain_mfn_range
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-10-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index d76f3b4e..986bec3 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -25,6 +25,16 @@ EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 int xen_platform_pci_unplug;
 EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
 
+/* TODO */
+int xen_remap_domain_mfn_range(struct vm_area_struct *vma,
+			       unsigned long addr,
+			       unsigned long mfn, int nr,
+			       pgprot_t prot, unsigned domid)
+{
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_range);
+
 void __ref xen_hvm_init_shared_info(void)
 {
 	int cpu;
-- 
1.7.2.5
