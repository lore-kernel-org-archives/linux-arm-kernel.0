From: hch@lst.de (Christoph Hellwig)
Date: Sat, 15 Sep 2018 09:03:00 +0200
Subject: clean up physical merging helpers
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
Message-ID: <20180915070300.GA10555@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jens, any comments?

On Tue, Sep 04, 2018 at 12:14:18PM -0700, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves various helpers related to merging based on physical
> addresses from the public headers into block/, moves the Xen special
> case from arch hooks into common code, cleans up the code a bit, and
> removes not nessecary includes from the block headers.
---end quoted text---
