From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  5 Oct 2010 11:06:34 +0900
Subject: [PATCH 0/4] ARM: SAMSUNG: Change VMALLOC_END and Samsung SoCs' VA
	space
Message-ID: <1286244398-9333-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes Samsung SoCs' VA space and VMALLOC_END this can help to use
more vmalloc() / ioremap() area with reducing useless area.

[PATCH 1/4] ARM: SAMSUNG: Move the start address of Samsung SoCs' VA space
[PATCH 2/4] ARM: S3C: Change VMALLOC_END to use more vmalloc()/ioremap() area
[PATCH 3/4] ARM: S5P: Change VMALLOC_END to use more vmalloc()/ioremap() area
[PATCH 4/4] ARM: S5P: Cleanup the S5P SoCs' VA address mapping
