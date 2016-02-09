From: shaun.ren@linux.com (Shaun Ren)
Date: Mon,  8 Feb 2016 17:31:16 -0800
Subject: [PATCH v2 0/9] Staging: rts5208: Coding style and dma mapping fixes
In-Reply-To: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fixes the coding style issues in rtsx_transport.c, and
dds a missing call dma_mapping_error() after dma_map_single().
