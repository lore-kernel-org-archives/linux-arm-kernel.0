From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Sep 2018 15:12:40 +0200
Subject: [RFC PATCH 3/3] dma-mapping: clear dma_parms on teardown, too
In-Reply-To: <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
Message-ID: <20180914131240.GB27141@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same here.  I don't even think we really need to clear the ops to
start with, but we if we want to do it I'd just do it directly in
the two callers.
