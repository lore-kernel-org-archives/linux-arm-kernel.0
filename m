From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 21 Sep 2018 09:29:20 +0200
Subject: [PATCH v5 21/22] nvmem: fix commenting style
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Message-ID: <20180921072921.19387-22-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a redundant '*/' as pointed out by checkpatch.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ff21402fbd7d..e44a1860a2b3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1374,7 +1374,7 @@ EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
  * @buf: buffer to be written to cell.
  *
  * Return: length of bytes written or negative error code on failure.
- * */
+ */
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf)
 {
@@ -1430,7 +1430,7 @@ EXPORT_SYMBOL_GPL(nvmem_device_read);
  * @buf: buffer to be written.
  *
  * Return: length of bytes written or negative error code on failure.
- * */
+ */
 int nvmem_device_write(struct nvmem_device *nvmem,
 		       unsigned int offset,
 		       size_t bytes, void *buf)
-- 
2.18.0
