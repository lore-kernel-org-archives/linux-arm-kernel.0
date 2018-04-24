From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 16:02:32 +0200
Subject: dma-debug cleanups, including removing the arch hook
Message-ID: <20180424140235.9125-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series has a few dma-debug cleanups, most notably removing the need
for architectures to explicitly initialize dma-debug.
