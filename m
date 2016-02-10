From: shaun.ren@linux.com (Shaun Ren)
Date: Tue,  9 Feb 2016 18:45:19 -0800
Subject: [PATCH v3 0/9] Staging: rts5208: Coding style and dma mapping fixes
In-Reply-To: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fixes the coding style issues in rtsx_transport.c, and
dds a missing call dma_mapping_error() after dma_map_single().

Changes since v2
 * Incorporated Joshua Clayton's suggestions regarding the block comments
