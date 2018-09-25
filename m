From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Sep 2018 13:30:04 -0700
Subject: clean up physical merging helpers
Message-ID: <20180925203009.1838-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

this series moves Xen special handling of block merges from arch hooks
into common code.  A previous version has been reviewed by Boris.
