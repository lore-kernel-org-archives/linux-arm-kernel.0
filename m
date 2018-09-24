From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Sep 2018 09:43:45 +0200
Subject: clean up physical merging helpers V2
Message-ID: <20180924074355.2802-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

this series moves various helpers related to merging based on physical
addresses from the public headers into block/, cleans up the code a bit
and removes not nessecary includes from the block headers.

Change since V1:
 - dropped the Xen related changed which are moved into a new series
   to be sent after this one
