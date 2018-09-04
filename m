From: hch@lst.de (Christoph Hellwig)
Date: Tue,  4 Sep 2018 12:14:18 -0700
Subject: clean up physical merging helpers
Message-ID: <20180904191431.20102-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

this series moves various helpers related to merging based on physical
addresses from the public headers into block/, moves the Xen special
case from arch hooks into common code, cleans up the code a bit, and
removes not nessecary includes from the block headers.
