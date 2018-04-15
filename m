From: hch@lst.de (Christoph Hellwig)
Date: Sun, 15 Apr 2018 16:59:35 +0200
Subject: centralize SWIOTLB config symbol and misc other cleanups
Message-ID: <20180415145947.1248-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.
